import 'package:desafio_target/src/home/models/info.dart';
import 'package:desafio_target/src/shared/components/text_link/text_link.dart';
import 'package:desafio_target/src/shared/extensions/theme.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        // print(constrains.maxWidth);
        final maxChars = 120;
        final textTooLong = widget.info.description.length > maxChars;

        var text = widget.info.description;

        if (textTooLong && !expanded) text = "${text.substring(0, maxChars)}...";
        return ListTile(
          title: Text(text),
          subtitle: textTooLong
              ? CustomTextButton(
                  text: expanded ? "Ver menos" : "Ver mais",
                  onTap: () => setState(() => expanded = !expanded),
                )
              : null,
          enabled: widget.enabled,
          isThreeLine: textTooLong && expanded,
          visualDensity: VisualDensity.standard,
          titleTextStyle: context.textTheme.titleMedium,
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
      },
    );
  }
}
