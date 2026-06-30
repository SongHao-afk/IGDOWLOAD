import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../repository/frequent_profile_repository.dart';
import 'glass_card.dart';

class FrequentProfilesCard extends StatelessWidget {
  const FrequentProfilesCard({
    super.key,
    required this.state,
    required this.cubit,
    this.onProfileTap,
  });

  final DownloaderState state;
  final DownloaderCubit cubit;
  final void Function(FrequentProfileItem item)? onProfileTap;

  @override
  Widget build(BuildContext context) {
    if (state.frequentProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEAF3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history_toggle_off_rounded,
                  color: Color(0xFFE1306C),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Truy cập thường xuyên',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF171321),
                    fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 104,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.frequentProfiles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = state.frequentProfiles[index];
                return _FrequentProfileTile(
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
