import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../downloader/page/downloader_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.showFullFlow});

  final bool showFullFlow;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _openingStore = false;

  List<_OnboardingItem> get _items {
    if (widget.showFullFlow) return _fullItems;

    return [_welcomeItem, _ratingItem];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsOnboardingCompleted, true);

    if (!mounted) return;

    await Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(builder: (_) => const DownloaderPage()),
    );
  }

  Future<void> _goNext() async {
    if (_currentPage >= _items.length - 1) {
      await _finishOnboarding();
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _rateApp() async {
    if (_openingStore) return;

    setState(() => _openingStore = true);
    final opened = await _openStoreReview();

    if (!mounted) return;

    setState(() => _openingStore = false);

    if (opened) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Rating will work after the app is available on the store.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<bool> _openStoreReview() async {
    for (final uri in _reviewUrisForPlatform()) {
      try {
        final opened = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (opened) return true;
      } catch (_) {
        continue;
      }
    }

    return false;
  }

  List<Uri> _reviewUrisForPlatform() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return [
          Uri.parse('market://details?id=${AppConstants.androidApplicationId}'),
          Uri.https('play.google.com', '/store/apps/details', {
            'id': AppConstants.androidApplicationId,
          }),
        ];
      case TargetPlatform.iOS:
        if (AppConstants.iosAppStoreId.isNotEmpty) {
          return [
            Uri.parse(
              'itms-apps://itunes.apple.com/app/id'
              '${AppConstants.iosAppStoreId}?action=write-review',
            ),
            Uri.https(
              'apps.apple.com',
              '/app/id${AppConstants.iosAppStoreId}',
              {'action': 'write-review'},
            ),
          ];
        }

        return [
          Uri.https('apps.apple.com', '/search', {
            'term': AppConstants.appName,
          }),
        ];
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return [
          Uri.https('play.google.com', '/store/apps/details', {
            'id': AppConstants.androidApplicationId,
          }),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = _items;
    final isLastPage = _currentPage == items.length - 1;
    final isRatingPage = items[_currentPage].isRating;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    Color(0xFF05070A),
                    Color(0xFF15121C),
                    Color(0xFF0E1822),
                    Color(0xFF070A0D),
                  ]
                : const [
                    Color(0xFFFFF8FB),
                    Color(0xFFFFEDF6),
                    Color(0xFFEAF8FF),
                    Color(0xFFFFFAF0),
                  ],
            stops: const [0, 0.34, 0.72, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 700;

              return Column(
                children: [
                  _OnboardingTopBar(
                    currentPage: _currentPage + 1,
                    totalPages: items.length,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _OnboardingSlide(
                          item: items[index],
                          compact: compact,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      compact ? 10 : 16,
                      20,
                      compact ? 14 : 22,
                    ),
                    child: Column(
                      children: [
                        _PageDots(
                          count: items.length,
                          activeIndex: _currentPage,
                        ),
                        const SizedBox(height: 16),
                        if (isLastPage && isRatingPage)
                          _RatingActions(
                            openingStore: _openingStore,
                            onRate: _rateApp,
                            onOpenApp: _finishOnboarding,
                          )
                        else
                          FilledButton.icon(
                            onPressed: _goNext,
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: const Text('Next'),
                            style: FilledButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                              minimumSize: const Size.fromHeight(54),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RatingActions extends StatelessWidget {
  const _RatingActions({
    required this.openingStore,
    required this.onRate,
    required this.onOpenApp,
  });

  final bool openingStore;
  final VoidCallback onRate;
  final VoidCallback onOpenApp;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        FilledButton.icon(
          onPressed: openingStore ? null : onRate,
          icon: openingStore
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: colors.onPrimary,
                  ),
                )
              : const Icon(Icons.star_rounded),
          label: Text(openingStore ? 'Opening store...' : 'Rate now'),
          style: FilledButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            minimumSize: const Size.fromHeight(54),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onOpenApp,
          icon: const Icon(Icons.download_done_rounded),
          label: const Text('Open app'),
          style: TextButton.styleFrom(
            foregroundColor: colors.onSurface.withOpacity(0.72),
            minimumSize: const Size.fromHeight(44),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingTopBar extends StatelessWidget {
  const _OnboardingTopBar({
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: colors.surface.withOpacity(isDark ? 0.10 : 0.84),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 9),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('lib/images/app.png', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              AppConstants.appName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 17,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: colors.surface.withOpacity(isDark ? 0.10 : 0.70),
              border: Border.all(color: colors.primary.withOpacity(0.16)),
            ),
            child: Text(
              '$currentPage/$totalPages',
              style: TextStyle(
                color: colors.onSurface.withOpacity(0.74),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.item, required this.compact});

  final _OnboardingItem item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final visualSide = math.min(
          constraints.maxWidth * (compact ? 0.68 : 0.78),
          compact ? 246.0 : 326.0,
        );

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(22, compact ? 8 : 16, 22, 8),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: visualSide,
                  child: Center(
                    child: item.isRating
                        ? _RatingVisual(item: item, size: visualSide)
                        : _ImageVisual(item: item, size: visualSide),
                  ),
                ),
                SizedBox(height: compact ? 18 : 28),
                _SlideText(item: item),
                SizedBox(height: compact ? 18 : 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final pill in item.pills)
                      _FeaturePill(
                        icon: pill.icon,
                        label: pill.label,
                        color: pill.color,
                      ),
                  ],
                ),
                if (item.isRating) ...[
                  SizedBox(height: compact ? 16 : 22),
                  Text(
                    'Please rate us if the app helps you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.62),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImageVisual extends StatelessWidget {
  const _ImageVisual({required this.item, required this.size});

  final _OnboardingItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                gradient: LinearGradient(
                  colors: item.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: item.gradient.first.withOpacity(0.26),
                    blurRadius: 34,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(item.imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            right: -4,
            bottom: 16,
            child: Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.surface,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.24),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(item.icon, color: colors.primary, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingVisual extends StatelessWidget {
  const _RatingVisual({required this.item, required this.size});

  final _OnboardingItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size < 260 ? 20 : 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: LinearGradient(
          colors: item.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.28),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: colors.surface.withOpacity(isDark ? 0.12 : 0.92),
          border: Border.all(color: Colors.white.withOpacity(0.40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_rounded, color: colors.primary, size: 42),
            const SizedBox(height: 14),
            Text(
              'Please rate us',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: size < 260 ? 20 : 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 14),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star_rounded, color: Color(0xFFFFC247), size: 34),
                  Icon(Icons.star_rounded, color: Color(0xFFFFC247), size: 34),
                  Icon(Icons.star_rounded, color: Color(0xFFFFC247), size: 34),
                  Icon(Icons.star_rounded, color: Color(0xFFFFC247), size: 34),
                  Icon(Icons.star_rounded, color: Color(0xFFFFC247), size: 34),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideText extends StatelessWidget {
  const _SlideText({required this.item});

  final _OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 28,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.onSurface.withOpacity(0.66),
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isDark
            ? color.withOpacity(0.16)
            : Colors.white.withOpacity(0.82),
        border: Border.all(color: color.withOpacity(isDark ? 0.36 : 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: colors.onSurface.withOpacity(0.78),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOut,
            width: i == activeIndex ? 28 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: i == activeIndex
                  ? colors.primary
                  : colors.onSurface.withOpacity(0.18),
            ),
          ),
      ],
    );
  }
}

class _OnboardingItem {
  const _OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icon,
    required this.pills,
    required this.gradient,
    this.isRating = false,
  });

  final String title;
  final String description;
  final String imagePath;
  final IconData icon;
  final List<_PillData> pills;
  final List<Color> gradient;
  final bool isRating;
}

class _PillData {
  const _PillData({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

const _pink = Color(0xFFFF4FA3);
const _orange = Color(0xFFFF8A1F);
const _blue = Color(0xFF405DE6);
const _cyan = Color(0xFF16C8E4);
const _green = Color(0xFF22C55E);
const _gold = Color(0xFFFFB703);

const _welcomeItem = _OnboardingItem(
  title: 'Welcome to IG Downloader',
  description:
      'Save the Instagram photos, videos, reels, and stories you love in just a few taps.',
  imagePath: 'lib/images/app.png',
  icon: Icons.auto_awesome_rounded,
  gradient: [_pink, _orange, _blue],
  pills: [
    _PillData(icon: Icons.flash_on_rounded, label: 'Quick', color: _orange),
    _PillData(icon: Icons.grid_view_rounded, label: 'Simple', color: _pink),
    _PillData(icon: Icons.download_rounded, label: 'Easy', color: _blue),
  ],
);

const _linkItem = _OnboardingItem(
  title: 'Copy a link and save',
  description:
      'Paste an Instagram link, check what you are saving, then download it when you are ready.',
  imagePath: 'lib/images/pic9.png',
  icon: Icons.link_rounded,
  gradient: [_cyan, _pink, _blue],
  pills: [
    _PillData(icon: Icons.content_paste_rounded, label: 'Paste', color: _cyan),
    _PillData(icon: Icons.visibility_rounded, label: 'Preview', color: _blue),
    _PillData(icon: Icons.file_download_rounded, label: 'Save', color: _pink),
  ],
);

const _profileItem = _OnboardingItem(
  title: 'Find posts from profiles',
  description:
      'Open a profile, browse posts or stories, and choose exactly what you want to keep.',
  imagePath: 'lib/images/pic10.png',
  icon: Icons.person_search_rounded,
  gradient: [_blue, _cyan, _pink],
  pills: [
    _PillData(
      icon: Icons.account_circle_rounded,
      label: 'Profiles',
      color: _blue,
    ),
    _PillData(icon: Icons.auto_stories_rounded, label: 'Stories', color: _pink),
    _PillData(icon: Icons.collections_rounded, label: 'Posts', color: _cyan),
  ],
);

const _privateItem = _OnboardingItem(
  title: 'Sign in only when needed',
  description:
      'Some private posts need Instagram login. Open Instagram in the app, sign in, and keep saving.',
  imagePath: 'lib/images/pic1.png',
  icon: Icons.lock_rounded,
  gradient: [_pink, _blue, _green],
  pills: [
    _PillData(icon: Icons.login_rounded, label: 'Sign in', color: _pink),
    _PillData(icon: Icons.public_rounded, label: 'Instagram', color: _blue),
    _PillData(
      icon: Icons.verified_user_rounded,
      label: 'Keep going',
      color: _green,
    ),
  ],
);

const _ratingItem = _OnboardingItem(
  title: 'Love the app? Tell us',
  description:
      'Your rating helps IG Downloader keep improving and stay easy to use.',
  imagePath: 'lib/images/app.png',
  icon: Icons.star_rounded,
  gradient: [_gold, _orange, _pink],
  isRating: true,
  pills: [
    _PillData(icon: Icons.star_rounded, label: '5 stars', color: _gold),
    _PillData(icon: Icons.favorite_rounded, label: 'Thank you', color: _pink),
  ],
);

const _fullItems = [
  _welcomeItem,
  _linkItem,
  _profileItem,
  _privateItem,
  _ratingItem,
];
