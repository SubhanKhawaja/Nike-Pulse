import 'package:flutter/material.dart';

class ResponsiveLayout {
  static const double mobileBreakpoint = 650;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static int getGridColumnCount(double width) {
    if (width < 600) return 2;
    if (width < 900) return 3;
    if (width < 1200) return 4;
    return 5;
  }

  static double getCardAspectRatio(double width) {
    if (width < 600) return 0.72;
    if (width < 900) return 0.75;
    return 0.8;
  }
}

class ResponsiveContentWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveContentWrapper({
    super.key,
    required this.child,
    this.maxWidth = 1200,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
