import 'package:flutter/material.dart' show Color, LinearGradient, TextStyle, Alignment, Colors;

final primaryGradientLightColors = <Color>[
  const Color(0xFF2380A8),
  const Color(0xff29978f),
];

final primaryGradientDarkColors = primaryGradientLightColors.map((e) => Color.alphaBlend(Colors.black38, e)).toList();

final primaryGradient = LinearGradient(
  colors: primaryGradientLightColors,
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
final secondaryGradient = LinearGradient(
  colors: primaryGradientDarkColors,
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const onPrimaryGradientTextStyle = TextStyle(color: Colors.white);
