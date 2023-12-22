import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../extensions/theme.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  const CustomTextButton({super.key, required this.text, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          Link(
            text: text,
            style: TextStyle(color: context.colorScheme.primary).merge(style),
            onTap: onTap,
          )
        ],
      ),
    );
  }
}

class TextLink extends StatelessWidget {
  final String text;
  final Uri uri;
  final TextStyle? style;

  const TextLink({super.key, required this.text, required this.uri, this.style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          Link.url(
            text: text,
            style: TextStyle(color: context.colorScheme.primary).merge(style),
            uri: uri,
          )
        ],
      ),
    );
  }
}

class Link extends TextSpan {
  Link({
    required super.text,
    required VoidCallback onTap,
    super.style,
  }) : super(recognizer: TapGestureRecognizer()..onTap = onTap);

  factory Link.url({
    required String text,
    required Uri uri,
    TextStyle? style,
  }) {
    return Link(
      text: text,
      onTap: () => launchUrl(uri),
      style: style,
    );
  }
}
