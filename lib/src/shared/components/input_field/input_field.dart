import 'package:flutter/material.dart';

import '../../extensions/theme.dart';

class CustomTextField extends StatelessWidget {
  final Widget? label;
  final String? hintText;

  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? errorTextStyle;
  final TextAlign? textAlign;

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? labelColor;
  final bool enabled;
  final bool autocorrect;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String? value)? onFieldSubmitted;
  final VoidCallback? onEditingComplete;

  final String? Function(String?)? validator;

  const CustomTextField({
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.hintTextStyle,
    this.labelTextStyle,
    this.errorTextStyle,
    this.textAlign,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
    this.enabled = true,
    this.autocorrect = true,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          DefaultTextStyle(
            style: context.textTheme.labelLarge!.merge(labelTextStyle),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: label,
            ),
          ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          autocorrect: autocorrect,
          validator: validator,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelStyle: labelTextStyle,
            hintStyle: hintTextStyle,
            errorStyle: errorTextStyle,
            filled: true,
            fillColor: backgroundColor ?? context.colorScheme.onInverseSurface,
            border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
          ),
        ),
      ],
    );
  }
}
