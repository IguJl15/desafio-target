import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/input_field/input_field.dart';
import '../../../shared/extensions/theme.dart';

class InfoInput extends StatefulWidget {
  final bool isEditing;
  final TextEditingController controller;

  final VoidCallback finishEditButtonPressed;
  final VoidCallback addItemButtonPressed;

  final FocusNode focusNode;

  const InfoInput({
    super.key,
    required this.isEditing,
    required this.controller,
    required this.finishEditButtonPressed,
    required this.addItemButtonPressed,
    required this.focusNode,
  });

  @override
  State<InfoInput> createState() => _InfoInputState();
}

class _InfoInputState extends State<InfoInput> {
  final _formKey = GlobalKey<FormState>();

  bool get isPlatformDesktop =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.fuchsia;

  void submit(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      final onPress = widget.isEditing ? widget.finishEditButtonPressed : widget.addItemButtonPressed;

      onPress();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isPlatformDesktop) FocusScope.of(context).requestFocus(widget.focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CustomTextField(
              hintText: "Digite seu texto",
              textAlign: TextAlign.center,
              controller: widget.controller,
              errorTextStyle: TextStyle(color: context.colorScheme.errorContainer),
              focusNode: widget.focusNode,
              onFieldSubmitted: (_) => submit(context),
              onEditingComplete: () {},
              validator: (value) {
                if (value == null) return null;

                if (value.isNotEmpty && value.length < 4) {
                  return "Texto muito curto";
                }

                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            height: 48,
            width: 48,
            child: IconButton.filledTonal(
              onPressed: () => submit(context),
              icon: widget.isEditing ? const Icon(Icons.task_alt) : const Icon(Icons.add_task),
              tooltip: widget.isEditing ? "Editar" : "Criar",
              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
          )
        ],
      ),
    );
  }
}
