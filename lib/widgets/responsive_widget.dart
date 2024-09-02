import 'package:flutter/material.dart';

import '../core/utils/app_breakpoints.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= AppBreakpoints.mobileMaxWidth) {
          return mobile;
        } else if (constraints.maxWidth <= AppBreakpoints.tabletMaxWidth) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
