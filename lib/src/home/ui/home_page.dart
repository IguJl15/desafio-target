import 'package:desafio_target/src/shared/components/input_field/input_field.dart';
import 'package:desafio_target/src/shared/extensions/theme.dart';
import 'package:desafio_target/src/shared/gradients/primary_gradient.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _newTaskTextController;
  late TextEditingController _editTaskTextController;

  // state
  final itens = <String>["Alo"];
  int? currentEditing = null;

  bool get isEditing => currentEditing != null;

  void addItem() {
    setState(() {
      if (isEditing) {
        itens[currentEditing!] = _editTaskTextController.text;
        _editTaskTextController.clear();
        currentEditing = null;
      } else {
        itens.add(_newTaskTextController.text);
        _newTaskTextController.clear();
      }
    });
  }

  void removeItem(int index) {
    if (isEditing) return;
    setState(() {
      itens.removeAt(index);
    });
  }

  void startEditing(int index) {
    if (isEditing) return;

    setState(() {
      currentEditing = index;

      _editTaskTextController.clear();
      _editTaskTextController.text = itens[currentEditing!];
    });
  }

  @override
  void initState() {
    super.initState();

    _newTaskTextController = TextEditingController();
    _editTaskTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: context.colorScheme.tertiary,
        height: null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: CustomTextField(
                hintText: "Digite seu texto",
                textAlign: TextAlign.center,
                controller: isEditing ? _editTaskTextController : _newTaskTextController,
                validator: (value) => value?.isEmpty == true ? "Texto muito curto" : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              height: 48,
              width: 48,
              child: IconButton.filledTonal(
                onPressed: addItem,
                icon: isEditing ? const Icon(Icons.task_alt) : const Icon(Icons.add_task),
                style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              ),
            )
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: primaryGradientTopToBottom),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Suas informações", style: context.textTheme.titleLarge!.merge(onPrimaryGradientTextStyle)),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 24),
                child: itens.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                        child: Text(
                          "Comece a adicionar informações no campo abaixo!",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge,
                        ),
                      )
                    : Column(
                        children: List.generate(itens.length, (index) {
                          final item = itens[index];
                          final textTooLong = item.length > 50;
                          return ListTile(
                            enabled: !isEditing || currentEditing == index,
                            title: Text(item),
                            titleTextStyle: context.textTheme.titleMedium,
                            visualDensity: VisualDensity.standard,
                            subtitle: textTooLong ? Text("Ver mais") : null,
                            isThreeLine: textTooLong,
                            contentPadding: const EdgeInsets.only(left: 16, right: 8),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: isEditing ? null : () => startEditing(index),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: isEditing ? null : () => removeItem(index),
                                  icon: const Icon(Icons.close),
                                  color: context.colorScheme.error,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
