import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final ButtonStyle? style;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.child,
    required this.onPressed,
    this.style,
    super.key,
  });

  final defaultStyle = const ButtonStyle(
    visualDensity: VisualDensity.standard,
    minimumSize: MaterialStatePropertyAll(
      Size(150, 40),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: defaultStyle.merge(style),
      onPressed: onPressed,
      child: child,
    );
  }
}
