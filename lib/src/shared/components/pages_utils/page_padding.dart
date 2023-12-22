import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets additionalPadding;
  const PagePadding({
    super.key,
    required this.maxWidth,
    required this.child,
    this.additionalPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final horizontalValue = (constraints.maxWidth - maxWidth).clamp(0, double.maxFinite) / 2;

        return Padding(
          padding: additionalPadding + EdgeInsets.symmetric(horizontal: horizontalValue),
          child: child,
        );
      },
    );
  }
}
