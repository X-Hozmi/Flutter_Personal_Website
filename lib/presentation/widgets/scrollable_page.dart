import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Scrollable, width-constrained page body.
///
/// Each routed page owns its scroll view. Sharing one scroll view around the
/// shell's `IndexedStack` would size every tab to the tallest page and carry
/// the scroll offset across tabs.
class ScrollablePage extends StatelessWidget {
  const ScrollablePage({super.key, required this.child});

  static const double maxContentWidth = 900;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 20 : 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
