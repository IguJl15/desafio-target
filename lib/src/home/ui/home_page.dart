import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../shared/components/input_field/input_field.dart';
import '../../shared/extensions/theme.dart';
import '../../shared/gradients/primary_gradient.dart';
import '../datasource/local_info_data_source.dart';
import '../stores/home_page_store.dart';
import 'components/info_tile.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageStore homeStore;

  late ReactionDisposer reactionDisposer;

  late TextEditingController _newTextController;
  late TextEditingController _editTextController;

  @override
  void initState() {
    super.initState();

    homeStore = HomePageStore(dataSource: LocalStorageInfoDataSource());
    _newTextController = TextEditingController() //
      ..addListener(() => homeStore.setNewTaskText(_newTextController.text));
    _editTextController = TextEditingController() //
      ..addListener(() => homeStore.setEditTaskText(_editTextController.text));

    homeStore.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    reactionDisposer = reaction(
      (_) => homeStore.newTaskText.isEmpty,
      (bool isEmpty) => isEmpty ? _newTextController.clear() : null,
    );
  }

  @override
  void dispose() {
    reactionDisposer();
    _newTextController.dispose();
    _editTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: homeStore,
      child: Scaffold(
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
                  controller: homeStore.isEditing ? _editTextController : _newTextController,
                  validator: (value) => value?.isEmpty == true ? "Texto muito curto" : null,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                height: 48,
                width: 48,
                child: IconButton.filledTonal(
                  onPressed: homeStore.isEditing ? homeStore.finishEditButtonPressed : homeStore.addItemButtonPressed,
                  icon: homeStore.isEditing ? const Icon(Icons.task_alt) : const Icon(Icons.add_task),
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
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child:
                      Text("Suas informações", style: context.textTheme.titleLarge!.merge(onPrimaryGradientTextStyle)),
                ),
                Observer(builder: (context) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 24),
                    child: homeStore.itens.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                            child: Text(
                              "Comece a adicionar informações no campo abaixo!",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge,
                            ),
                          )
                        : Column(
                            children: List.generate(homeStore.itens.length, (index) {
                              final item = homeStore.itens[index];
                              return InfoTile(
                                info: item,
                                enabled: !homeStore.isEditing || homeStore.currentEditing == index,
                                onEditButtonPressed: () => homeStore.editButtonPressed(index),
                                onRemoveButtonPressed: () => homeStore.removeItemButtonPressed(index),
                              );
                            }),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
