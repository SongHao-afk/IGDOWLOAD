import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/downloader_cubit.dart';

class ServerSettingsSheet extends StatefulWidget {
  const ServerSettingsSheet({super.key});

  @override
  State<ServerSettingsSheet> createState() => _ServerSettingsSheetState();
}

class _ServerSettingsSheetState extends State<ServerSettingsSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: context.read<DownloaderCubit>().state.serverBaseUrl,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        18,
        12,
        18,
        MediaQuery.of(context).viewInsets.bottom + 18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.45),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Kết nối server',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Server URL',
              hintText: 'http://10.0.2.2:3000',
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: () async {
              await context.read<DownloaderCubit>().saveServer(controller.text);

              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Lưu server'),
          ),
        ],
      ),
    );
  }
}
