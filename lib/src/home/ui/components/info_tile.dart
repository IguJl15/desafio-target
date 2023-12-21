import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/text_link/text_link.dart';
import '../../../shared/extensions/theme.dart';
import '../../models/info.dart';

class InfoTile extends StatefulWidget {
  final Info info;
  final bool enabled;

  final VoidCallback onEditButtonPressed;
  final VoidCallback onRemoveButtonPressed;

  const InfoTile({
    required this.info,
    required this.enabled,
    required this.onEditButtonPressed,
    required this.onRemoveButtonPressed,
    super.key,
  });

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool expanded = false;
  bool textTooLong = false;

  void titleOverflow() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        textTooLong = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.titleMedium;
    return InfoTitleBuilder(
        info: widget.info,
        expanded: expanded,
        textStyle: titleStyle,
        builder: (context, title, overflow) {
          return ListTile(
            title: title,
            subtitle: overflow
                ? CustomTextButton(
                    text: expanded ? "Ver menos" : "Ver mais",
                    onTap: () => setState(() => expanded = !expanded),
                  )
                : null,
            enabled: widget.enabled,
            isThreeLine: expanded && overflow,
            visualDensity: VisualDensity.standard,
            titleTextStyle: titleStyle,
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: widget.enabled ? widget.onEditButtonPressed : null,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: widget.enabled ? widget.onRemoveButtonPressed : null,
                  icon: const Icon(Icons.close),
                  color: context.colorScheme.error,
                )
              ],
            ),
          );
        });
  }
}

class InfoTitleBuilder extends StatelessWidget {
  final Info info;
  final bool expanded;
  final TextStyle? textStyle;
  final Widget Function(BuildContext context, Widget titleWidget, bool overflow) builder;

  const InfoTitleBuilder({
    required this.builder,
    super.key,
    required this.info,
    required this.expanded,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextHeightBehavior(
      textHeightBehavior: TextHeightBehavior(),
      child: AutoSizeBuilder(
        text: TextSpan(text: info.description),
        maxLines: 2,
        wrapWords: true,
        minFontSize: textStyle?.fontSize ?? 16,
        builder: (context, scale, overflow) {
          final title = AutoSizeText(
            info.description,
            maxLines: expanded ? null : 2,
            wrapWords: true,
            minFontSize: textStyle?.fontSize ?? 16,
            overflow: TextOverflow.fade,
          );

          return builder(context, title, overflow);
        },
      ),
    );
  }
}
