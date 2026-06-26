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
  });

  final DownloaderState state;
  final DownloaderCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (state.frequentProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history_toggle_off_rounded),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Truy cập thường xuyên',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                  onTap: () => cubit.loadFrequentProfileAll(item),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: ClipOval(
                child: item.avatarUrl.trim().isEmpty
                    ? Container(
                        color: Colors.black26,
                        child: const Icon(Icons.person_rounded),
                      )
                    : Image.network(
                        item.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: Colors.black26,
                            child: const Icon(Icons.person_rounded),
                          );
                        },
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
