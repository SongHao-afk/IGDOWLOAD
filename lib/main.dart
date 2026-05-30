import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const IgDownloaderApp());
}

class IgDownloaderApp extends StatelessWidget {
  const IgDownloaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IG Downloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class IgMediaItem {
  final int id;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String downloadUrl;

  IgMediaItem({
    required this.id,
    required this.type,
    required this.downloadUrl,
    this.width,
    this.height,
    this.duration,
  });

  factory IgMediaItem.fromJson(Map<String, dynamic> json) {
    return IgMediaItem(
      id: json['id'] ?? 0,
      type: json['type'] ?? 'image',
      width: json['width'],
      height: json['height'],
      duration: json['duration'],
      downloadUrl: json['downloadUrl'] ?? '',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController urlCtrl = TextEditingController();
  final Dio dio = Dio();

  final String serverBaseUrl = 'http://10.126.40.99:3000';

  bool loading = false;
  String status = '';
  List<IgMediaItem> media = [];

  Future<void> resolveMedia() async {
    final url = urlCtrl.text.trim();

    if (url.isEmpty) {
      setState(() {
        status = 'Dán link Instagram trước đã.';
      });
      return;
    }

    setState(() {
      loading = true;
      status = 'Đang bú link...';
      media = [];
    });

    try {
      final res = await http.post(
        Uri.parse('$serverBaseUrl/resolve'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200 || data['success'] != true) {
        throw Exception(data['error'] ?? 'Resolve lỗi');
      }

      final List list = data['media'] ?? [];

      setState(() {
        media = list.map((x) => IgMediaItem.fromJson(x)).toList();
        status = 'Bắt được ${media.length} media.';
      });
    } catch (e) {
      setState(() {
        status = 'Lỗi: $e';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> requestSavePermission() async {
    if (!Platform.isAndroid) return;

    await Permission.photos.request();
    await Permission.videos.request();
    await Permission.storage.request();
  }

  Future<void> downloadMedia(IgMediaItem item) async {
    await requestSavePermission();

    setState(() {
      status = 'Đang tải media ${item.id}...';
    });

    try {
      final tempDir = await getTemporaryDirectory();

      final ext = item.type == 'video' ? 'mp4' : 'jpg';
      final filename =
          'instagram_${DateTime.now().millisecondsSinceEpoch}_${item.id}.$ext';

      final tempPath = '${tempDir.path}/$filename';

      final proxyUrl =
          '$serverBaseUrl/download?url=${Uri.encodeComponent(item.downloadUrl)}';

      await dio.download(
        proxyUrl,
        tempPath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
        onReceiveProgress: (received, total) {
          if (total <= 0) return;

          final percent = ((received / total) * 100).toStringAsFixed(0);

          setState(() {
            status = 'Đang tải media ${item.id}: $percent%';
          });
        },
      );

      if (item.type == 'video') {
        await Gal.putVideo(tempPath, album: 'IG Downloader');
      } else {
        await Gal.putImage(tempPath, album: 'IG Downloader');
      }

      setState(() {
        status = 'Đã lưu vào album IG Downloader.';
      });
    } catch (e) {
      setState(() {
        status = 'Tải lỗi: $e';
      });
    }
  }

  Future<void> downloadAll() async {
    if (media.isEmpty) return;

    for (final item in media) {
      await downloadMedia(item);
    }

    setState(() {
      status = 'Tải xong tất cả vào album IG Downloader.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IG Downloader')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: urlCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Dán link Instagram',
                hintText: 'https://www.instagram.com/p/...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: loading ? null : resolveMedia,
                    child: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Bú link'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: media.isEmpty ? null : downloadAll,
                    child: const Text('Tải tất cả'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: Text(status)),
            const SizedBox(height: 12),
            Expanded(
              child: media.isEmpty
                  ? const Center(child: Text('Chưa có media.'))
                  : ListView.builder(
                      itemCount: media.length,
                      itemBuilder: (context, index) {
                        final item = media[index];

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              item.type == 'video'
                                  ? Icons.play_circle
                                  : Icons.image,
                            ),
                            title: Text(
                              '${item.type.toUpperCase()} #${item.id}',
                            ),
                            subtitle: Text(
                              '${item.width ?? '?'} x ${item.height ?? '?'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: FilledButton(
                              onPressed: () => downloadMedia(item),
                              child: const Text('Tải'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
