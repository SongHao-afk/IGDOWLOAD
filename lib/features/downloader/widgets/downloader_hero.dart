import 'package:flutter/material.dart';

import '../cubit/downloader_state.dart';

class DownloaderHero extends StatelessWidget {
  const DownloaderHero({super.key, required this.state});

  final DownloaderState state;

  @override
  Widget build(BuildContext context) {
    return _hero(context, state);
  }

  Widget _hero(BuildContext context, DownloaderState state) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 34),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.34),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tải ảnh, reel, story',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.privateMode
                    ? 'Private mode: dùng đăng nhập Instagram trên máy này'
                    : 'Public mode: dùng session mặc định',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 22,
          bottom: -28,
          child: _bubbleImage('lib/images/anh1.jpg', 58),
        ),
        Positioned(
          left: 88,
          bottom: -18,
          child: _bubbleImage('lib/images/anh2.jpg', 44),
        ),
        Positioned(
          right: 88,
          bottom: -25,
          child: _bubbleImage('lib/images/anh3.jpg', 52),
        ),
        Positioned(
          right: 26,
          bottom: -14,
          child: _bubbleImage('lib/images/anh4.jpg', 40),
        ),
      ],
    );
  }

  Widget _bubbleImage(String path, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
}
