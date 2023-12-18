import 'package:flutter/material.dart';

class SmallProgressIndicator extends StatelessWidget {
  final Color? color;
  const SmallProgressIndicator({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 20,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 3,
      ),
    );
  }
}
