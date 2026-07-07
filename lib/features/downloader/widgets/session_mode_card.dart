import 'package:flutter/material.dart';

class SessionModeCard extends StatelessWidget {
  final bool privateMode;
  final bool hasPrivateCookie;
  final bool sessionBusy;
  final ValueChanged<bool> onModeChanged;
  final VoidCallback? onLogin;
  final VoidCallback? onLogout;

  const SessionModeCard({
    super.key,
    required this.privateMode,
    required this.hasPrivateCookie,
    required this.sessionBusy,
    required this.onModeChanged,
    required this.onLogin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 14, bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: color.surface.withOpacity(0.86),
        boxShadow: [
          BoxShadow(
            color: color.primary.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: color.primary.withOpacity(0.14), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Chế độ tải',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(
                value: false,
                label: Text('Public'),
                icon: Icon(Icons.public_rounded),
              ),
              ButtonSegment<bool>(
                value: true,
                label: Text('Private'),
                icon: Icon(Icons.lock_rounded),
              ),
            ],
            selected: {privateMode},
            onSelectionChanged: sessionBusy
                ? null
                : (values) => onModeChanged(values.first),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: privateMode
                ? Column(
                    key: const ValueKey('private-mode'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        hasPrivateCookie
                            ? 'Bạn đã kết nối tài khoản Instagram.'
                            : 'Đăng nhập Instagram để tải nội dung mà tài khoản của bạn có quyền xem.',
                        style: TextStyle(
                          color: color.onSurface.withOpacity(0.72),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: sessionBusy || hasPrivateCookie
                                  ? null
                                  : onLogin,
                              icon: sessionBusy
                                  ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: color.onPrimary,
                                      ),
                                    )
                                  : const Icon(Icons.login_rounded),
                              label: const Text('Đăng nhập'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: sessionBusy || !hasPrivateCookie
                                  ? null
                                  : onLogout,
                              icon: const Icon(Icons.logout_rounded),
                              label: const Text('Đăng xuất'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    'Bạn đang tải nội dung công khai mà không cần đăng nhập.',
                    key: const ValueKey('public-mode'),
                    style: TextStyle(
                      color: color.onSurface.withOpacity(0.72),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
