import 'package:flutter/material.dart' show Color, LinearGradient, TextStyle, Alignment, Colors;

const primaryGradientColors = <Color>[
  Color(0Xff1e4e62),
  Color(0xff29978f),
];
const primaryGradientTopToBottom = LinearGradient(
  colors: primaryGradientColors,
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const onPrimaryGradientTextStyle = TextStyle(color: Colors.white);
