import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../cubit/downloader_state.dart';

class DownloaderHero extends StatefulWidget {
  const DownloaderHero({super.key, required this.state});

  final DownloaderState state;

  @override
  State<DownloaderHero> createState() => _DownloaderHeroState();
}

class _DownloaderHeroState extends State<DownloaderHero>
    with SingleTickerProviderStateMixin {
  static const _topHeartImage = 'lib/images/pic1.png';
  static const _topCircleImage1 = 'lib/images/pic2.png';
  static const _topCircleImage2 = 'lib/images/pic3.png';
  static const _topCircleImage3 = 'lib/images/pic4.png';
  static const _bottomBubbleImage1 = 'lib/images/pic5.png';
  static const _bottomBubbleImage2 = 'lib/images/pic6.png';
  static const _bottomBubbleImage3 = 'lib/images/pic7.png';
  static const _bottomBubbleImage4 = 'lib/images/pic8.png';

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * math.pi * 2;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: isDark
                      ? const [
                          Color(0xFF171A12),
                          Color(0xFF242016),
                          Color(0xFF1A222C),
                          Color(0xFF0B1015),
                          Color(0xFF18130D),
                          Color(0xFF070A0D),
                        ]
                      : [
                          color.primary,
                          color.tertiary,
                          color.secondary,
                          color.primary.withOpacity(0.82),
                          color.tertiary.withOpacity(0.90),
                          color.secondary.withOpacity(0.92),
                        ],
                  stops: const [0.0, 0.22, 0.48, 0.70, 0.84, 1.0],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.primary.withOpacity(0.28),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  _floating(
                    t: t,
                    phase: 0.2,
                    x: -30,
                    y: -16,
                    dx: 9,
                    dy: 5,
                    child: Transform.rotate(
                      angle: -0.18,
                      child: Container(
                        width: 180,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                  _floating(
                    t: t,
                    phase: 0.95,
                    x: null,
                    y: 2,
                    right: 64,
                    dx: 5,
                    dy: 9,
                    child: _heartImage(_topHeartImage, 38),
                  ),
                  _floating(
                    t: t,
                    phase: 2.3,
                    x: null,
                    y: 42,
                    right: 92,
                    dx: 7,
                    dy: 7,
                    child: _bubbleImage(_topCircleImage1, 42),
                  ),
                  _floating(
                    t: t,
                    phase: 3.4,
                    x: null,
                    y: null,
                    right: 46,
                    bottom: 12,
                    dx: 7,
                    dy: 6,
                    child: _bubbleImage(_topCircleImage2, 34),
                  ),
                  _floating(
                    t: t,
                    phase: 4.2,
                    x: null,
                    y: 18,
                    right: 18,
                    dx: 5,
                    dy: 8,
                    child: _smallAvatar(_topCircleImage3),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      Text(
                        l10n.heroTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.08,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.state.hasPrivateCookie
                            ? l10n.heroConnected
                            : l10n.heroDescription,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.90),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _floatingBubble(
              t: t,
              phase: 1.1,
              left: 22,
              bottom: -28,
              path: _bottomBubbleImage1,
              size: 58,
              dx: 5,
              dy: 8,
            ),
            _floatingBubble(
              t: t,
              phase: 2.6,
              left: 88,
              bottom: -18,
              path: _bottomBubbleImage2,
              size: 44,
              dx: 6,
              dy: 6,
            ),
            _floatingBubble(
              t: t,
              phase: 3.6,
              right: 88,
              bottom: -25,
              path: _bottomBubbleImage3,
              size: 52,
              dx: 5,
              dy: 9,
            ),
            _floatingBubble(
              t: t,
              phase: 4.8,
              right: 26,
              bottom: -14,
              path: _bottomBubbleImage4,
              size: 40,
              dx: 4,
              dy: 6,
            ),
          ],
        );
      },
    );
  }

  Widget _floating({
    required double t,
    required double phase,
    required Widget child,
    double? x,
    double? y,
    double? right,
    double? bottom,
    required double dx,
    required double dy,
  }) {
    final offset = Offset(
      math.sin(t + phase) * dx,
      math.cos(t + phase * 1.17) * dy,
    );

    return Positioned(
      left: x,
      top: y,
      right: right,
      bottom: bottom,
      child: Transform.translate(offset: offset, child: child),
    );
  }

  Widget _floatingBubble({
    required double t,
    required double phase,
    required String path,
    required double size,
    required double dx,
    required double dy,
    double? left,
    double? right,
    double? bottom,
  }) {
    return _floating(
      t: t,
      phase: phase,
      x: left,
      right: right,
      bottom: bottom,
      dx: dx,
      dy: dy,
      child: _bubbleImage(path, size),
    );
  }

  Widget _heartImage(String path, double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: _HeartClipper(),
          child: Image.asset(
            path,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Icon(
          Icons.favorite_border_rounded,
          color: Colors.white.withOpacity(0.82),
          size: size + 4,
        ),
      ],
    );
  }

  Widget _smallAvatar(String path) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.32),
      ),
      child: ClipOval(child: Image.asset(path, fit: BoxFit.cover)),
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

class _HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    return Path()
      ..moveTo(width * 0.5, height * 0.86)
      ..cubicTo(
        width * 0.08,
        height * 0.58,
        0,
        height * 0.34,
        width * 0.18,
        height * 0.16,
      )
      ..cubicTo(
        width * 0.33,
        height * 0.02,
        width * 0.48,
        height * 0.12,
        width * 0.5,
        height * 0.28,
      )
      ..cubicTo(
        width * 0.52,
        height * 0.12,
        width * 0.67,
        height * 0.02,
        width * 0.82,
        height * 0.16,
      )
      ..cubicTo(
        width,
        height * 0.34,
        width * 0.92,
        height * 0.58,
        width * 0.5,
        height * 0.86,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
