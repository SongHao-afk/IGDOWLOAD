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
    if (state.frequentProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleProfiles = state.frequentProfiles
        .take(_maxVisibleProfiles)
        .toList(growable: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF5FB),
            Color(0xFFFFEEF6),
            Color(0xFFFFF9F1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Color(0xFFFFDDEB), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1AE1306C),
            blurRadius: 24,
            offset: Offset(0, 10),
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
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF7A30),
                    Color(0xFFE1306C),
                    Color(0xFF405DE6),
                  ],
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
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF7A30),
                      Color(0xFFE1306C),
                      Color(0xFF405DE6),
                    ],
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
                  'Truy cập thường xuyên',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF171321),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
    final title = item.username.trim().isEmpty
        ? 'Profile'
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFD600),
                    Color(0xFFFF7A30),
                    Color(0xFFFF2F75),
                    Color(0xFFC13584),
                    Color(0xFF405DE6),
                  ],
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
                          color: const Color(0xFFFFEAF3),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Color(0xFFE1306C),
                          ),
                        )
                      : Image.network(
                          item.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              color: const Color(0xFFFFEAF3),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Color(0xFFE1306C),
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
