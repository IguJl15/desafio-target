import 'package:flutter/material.dart';

import '../../extensions/theme.dart';

class CustomTextField extends StatelessWidget {
  final Widget label;
  final TextStyle? labelTextStyle;
  final TextStyle? errorTextStyle;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? labelColor;
  final bool enabled;
  final bool autocorrect;

  const CustomTextField({
    required this.label,
    required this.controller,
    required this.keyboardType,
    this.labelTextStyle,
    this.errorTextStyle,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
    this.enabled = true,
    this.autocorrect = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: context.textTheme.labelLarge!.merge(labelTextStyle),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: label,
          ),
        ),
        Card(
          elevation: 2,
          margin: null,
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            enabled: enabled,
            autocorrect: autocorrect,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            labelStyle: labelTextStyle,
            errorStyle: errorTextStyle,
              filled: true,
              fillColor: backgroundColor ?? context.colorScheme.onInverseSurface,
              border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
