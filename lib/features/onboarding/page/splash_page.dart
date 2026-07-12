import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
      lowerBound: 0.94,
      upperBound: 1,
    )..forward();

    unawaited(_openNextPage());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openNextPage() async {
    final startedAt = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final completed =
        prefs.getBool(AppConstants.prefsOnboardingCompleted) ?? false;

    final elapsed = DateTime.now().difference(startedAt);
    const minimumSplash = Duration(milliseconds: 950);

    if (elapsed < minimumSplash) {
      await Future<void>.delayed(minimumSplash - elapsed);
    }

    if (!mounted) return;

    await Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(
        builder: (_) => OnboardingPage(showFullFlow: !completed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    Color(0xFF05070A),
                    Color(0xFF171018),
                    Color(0xFF101B24),
                  ]
                : [
                    colors.primary.withOpacity(0.18),
                    const Color(0xFFFFF7FA),
                    colors.secondary.withOpacity(0.20),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutBack,
                    ),
                    child: Container(
                      width: 124,
                      height: 124,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: colors.surface.withOpacity(isDark ? 0.10 : 0.78),
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withOpacity(0.28),
                            blurRadius: 38,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Image.asset(
                          'lib/images/app.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppConstants.appName,
                      maxLines: 1,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Save Instagram photos and videos beautifully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.68),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: colors.primary,
                      backgroundColor: colors.primary.withOpacity(0.14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
