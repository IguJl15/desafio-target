import 'package:desafio_target/src/shared/components/input_field/input_field.dart';
import 'package:flutter/material.dart';

class InfoInput extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: CustomTextField(
            hintText: "Digite seu texto",
            textAlign: TextAlign.center,
            controller: controller,
            validator: (value) => value?.isEmpty == true ? "Texto muito curto" : null,
            focusNode: focusNode,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          height: 48,
          width: 48,
          child: IconButton.filledTonal(
            onPressed: isEditing ? finishEditButtonPressed : addItemButtonPressed,
            icon: isEditing ? const Icon(Icons.task_alt) : const Icon(Icons.add_task),
            style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        )
      ],
    );
  }
}
