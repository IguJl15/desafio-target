import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
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

  void showDeleteConfirmationDialog(BuildContext context) async {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: const Text("Tem certeza que deseja excluir essa informação?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              widget.onRemoveButtonPressed();
              Navigator.pop(context, true);
            },
            child: Text("Excluir", style: TextStyle(color: context.colorScheme.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.titleMedium;
    return _InfoTitleBuilder(
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
                  tooltip: "Editar",
                ),
                IconButton(
                  onPressed: widget.enabled ? () => showDeleteConfirmationDialog(context) : null,
                  icon: const Icon(Icons.close),
                  color: context.colorScheme.error,
                  tooltip: "Apagar",
                )
              ],
            ),
          );
        });
  }
}

class _InfoTitleBuilder extends StatelessWidget {
  final Info info;
  final bool expanded;
  final TextStyle? textStyle;
  final Widget Function(BuildContext context, Widget titleWidget, bool overflow) builder;

  const _InfoTitleBuilder({
    required this.builder,
    required this.info,
    required this.expanded,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextHeightBehavior(
      textHeightBehavior: const TextHeightBehavior(),
      child: AutoSizeBuilder(
        text: TextSpan(children: [TextSpan(text: info.description)]),
        maxLines: 2,
        wrapWords: true,
        minFontSize: textStyle?.fontSize ?? 16,
        builder: (context, scale, overflow) {
          final title = Tooltip(
            message: info.description,
            waitDuration: Durations.extralong4,
            child: AutoSizeText(
              info.description,
              maxLines: expanded ? null : 2,
              wrapWords: true,
              minFontSize: textStyle?.fontSize ?? 16,
              overflow: TextOverflow.fade,
            ),
          );

          return builder(context, title, overflow);
        },
      ),
    );
  }
}
