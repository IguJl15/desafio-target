import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../auth/stores/login_store.dart';
import '../../auth/ui/login_page.dart';
import '../../shared/extensions/theme.dart';
import '../../shared/gradients/primary_gradient.dart';
import '../datasource/local_info_data_source.dart';
import '../stores/home_page_store.dart';
import 'components/info_input.dart';
import 'components/info_tile.dart';
import 'components/page_title.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageStore homeStore;

  late ReactionDisposer reactionDisposer;
  late ReactionDisposer editReactionDisposer;

  late TextEditingController _newTextController;
  late TextEditingController _editTextController;

  final FocusNode inputFocusNode = FocusNode();

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
    editReactionDisposer = reaction(
      (_) => homeStore.editTaskText.isEmpty,
      (bool isEmpty) {
        if (isEmpty) {
          _editTextController.clear();
        } else {
          _editTextController.value = TextEditingValue(
            text: homeStore.editTaskText,
            selection: TextSelection.collapsed(offset: homeStore.editTaskText.length),
          );
        }
      },
    );
  }

  void logoutButtonPressed() {
    final loginStore = context.read<LoginStore>();
    loginStore.logout();

    Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: homeStore,
      child: Scaffold(
        bottomNavigationBar: Observer(
          builder: (context) {
            FocusScope.of(context).requestFocus(inputFocusNode);

            return BottomAppBar(
              color: context.colorScheme.tertiary,
              child: InfoInput(
                isEditing: homeStore.isEditing,
                controller: homeStore.isEditing ? _editTextController : _newTextController,
                finishEditButtonPressed: homeStore.finishEditButtonPressed,
                addItemButtonPressed: homeStore.addItemButtonPressed,
                focusNode: inputFocusNode,
              ),
            );
          },
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: primaryGradientTopToBottom),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageTitle(logoutButtonPressed: logoutButtonPressed),
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
                            children: List.generate(
                              homeStore.itens.length,
                              (index) {
                                final item = homeStore.itens[index];
                                return InfoTile(
                                  info: item,
                                  enabled: !homeStore.isEditing || homeStore.currentEditing == index,
                                  onEditButtonPressed: () => homeStore.editButtonPressed(index),
                                  onRemoveButtonPressed: () => homeStore.removeItemButtonPressed(index),
                                );
                              },
                            ),
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

  @override
  void dispose() {
    reactionDisposer();
    _newTextController.dispose();
    _editTextController.dispose();
    super.dispose();
  }
}
