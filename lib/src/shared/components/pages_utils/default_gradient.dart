import 'package:desafio_target/src/shared/gradients/primary_gradient.dart';
import 'package:flutter/material.dart';

class DefaultPageGradient extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  DefaultPageGradient({
    required this.child,
    this.padding,
    this.height,
    this.width,
    super.key,
  });

  static final primaryGradientColors = <Color>[
    Color(0xFF2280aa),
    Color.fromARGB(255, 139, 206, 200),
  ];

  static final secondaryGradientColors = primaryGradientColors.map((e) => Color.alphaBlend(Colors.black26, e)).toList();

  static final primaryGradient = LinearGradient(
    colors: primaryGradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final secondaryGradient = LinearGradient(
    colors: secondaryGradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
// 0xFF226886
// 0xff29978f
    final gradient = switch (brightness) {
      Brightness.light => primaryGradient,
      Brightness.dark => secondaryGradient,
    };
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      padding: padding,
      height: height,
      width: width,
      child: child,
    );
  }
}
