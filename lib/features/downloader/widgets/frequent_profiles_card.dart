import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../repository/frequent_profile_repository.dart';

class FrequentProfilesCard extends StatelessWidget {
  const FrequentProfilesCard({
    super.key,
    required this.state,
    required this.cubit,
    this.onProfileTap,
  });

  static const int _maxVisibleProfiles = 15;

  final DownloaderState state;
  final DownloaderCubit cubit;
  final void Function(FrequentProfileItem item)? onProfileTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final visibleProfiles = state.frequentProfiles
        .take(_maxVisibleProfiles)
        .toList(growable: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        gradient: LinearGradient(
          colors: [
            color.surface,
            Color.alphaBlend(color.primary.withOpacity(0.10), color.surface),
            Color.alphaBlend(color.tertiary.withOpacity(0.08), color.surface),
            Color.alphaBlend(color.secondary.withOpacity(0.08), color.surface),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.primary.withOpacity(0.18), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.primary.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [color.primary, color.tertiary, color.secondary],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [color.primary, color.tertiary, color.secondary],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: const Icon(
                  Icons.history_toggle_off_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Trang cá nhân đã xem gần đây',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF171321),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (visibleProfiles.isEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 82,
                        height: 82,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              color.primary,
                              color.tertiary,
                              color.secondary,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_search_rounded,
                          size: 42,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Chưa có trang cá nhân nào',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Những trang cá nhân bạn đã xem sẽ xuất hiện tại đây.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.35,
                          color: Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withOpacity(0.65),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: visibleProfiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 104,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = visibleProfiles[index];

                  return Center(
                    child: _FrequentProfileTile(
                      item: item,
                      onTap: () {
                        final handler = onProfileTap;
                        if (handler != null) {
                          handler(item);
                          return;
                        }

                        cubit.loadFrequentProfileAll(item);
                      },
                      onLongPress: () => cubit.removeFrequentProfile(item),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _FrequentProfileTile extends StatelessWidget {
  const _FrequentProfileTile({
    required this.item,
    required this.onTap,
    required this.onLongPress,
  });

  final FrequentProfileItem item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final title = item.username.trim().isEmpty
        ? 'Tài khoản'
        : '@${item.username.trim()}';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 86,
        child: Column(
          children: [
            Container(
              width: 66,
              height: 66,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [color.primary, color.tertiary, color.secondary],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: item.avatarUrl.trim().isEmpty
                      ? Container(
                          color: color.primary.withOpacity(0.10),
                          child: Icon(
                            Icons.person_rounded,
                            color: color.primary,
                          ),
                        )
                      : Image.network(
                          item.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              color: color.primary.withOpacity(0.10),
                              child: Icon(
                                Icons.person_rounded,
                                color: color.primary,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
