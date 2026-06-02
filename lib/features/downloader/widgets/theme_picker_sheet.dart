import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/theme_cubit.dart';

class ThemePickerSheet extends StatelessWidget {
  const ThemePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
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
            'Chọn màu giao diện',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          _tile(context, '🌸 Hồng bóng', AppThemeMode.pink),
          _tile(context, '💙 Xanh lam nhạt', AppThemeMode.blue),
          _tile(context, '❤️ Đỏ', AppThemeMode.red),
          _tile(context, '🤍 Trắng', AppThemeMode.white),
          _tile(context, '🌙 Tối', AppThemeMode.dark),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String title, AppThemeMode mode) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        context.read<ThemeCubit>().changeTheme(mode);
        Navigator.pop(context);
      },
    );
  }
}
