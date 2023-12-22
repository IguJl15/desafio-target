import 'package:desafio_target/src/shared/components/pages_utils/default_gradient.dart';
import 'package:desafio_target/src/shared/components/pages_utils/page_padding.dart';
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

  static const double contentMaxWidth = 900;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageStore homeStore;

  late ReactionDisposer reactionDisposer;
  late ReactionDisposer editReactionDisposer;

  late TextEditingController _newTextController;
  late TextEditingController _editTextController;

  late final FocusNode inputFocusNode;

  @override
  void initState() {
    super.initState();

    homeStore = HomePageStore(dataSource: LocalStorageInfoDataSource());
    _newTextController = TextEditingController() //
      ..addListener(() => homeStore.setNewTaskText(_newTextController.text));
    _editTextController = TextEditingController() //
      ..addListener(() => homeStore.setEditTaskText(_editTextController.text));

    homeStore.init();

    inputFocusNode = FocusNode();
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
    final viewInsets = MediaQuery.viewInsetsOf(context);

    final babColor = switch (MediaQuery.platformBrightnessOf(context)) {
      Brightness.light => context.colorScheme.tertiary,
      Brightness.dark => Color.alphaBlend(context.colorScheme.surface.withOpacity(0.5), context.colorScheme.scrim),
    };

    return Provider.value(
      value: homeStore,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: BottomAppBar(
            color: babColor,
            height: 96 + viewInsets.bottom,
            elevation: 0,
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12.0 + viewInsets.bottom),
            child: Observer(
              builder: (context) {
                return PagePadding(
                  maxWidth: HomePage.contentMaxWidth,
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
          ),
          body: DefaultPageGradient(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PagePadding(
                    maxWidth: HomePage.contentMaxWidth,
                    child: PageTitle(logoutButtonPressed: logoutButtonPressed),
                  ),
                  PagePadding(
                    maxWidth: HomePage.contentMaxWidth,
                    child: Observer(
                      builder: (context) {
                        return Card(
                          elevation: 0.5,
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
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    reactionDisposer();
    _newTextController.dispose();
    _editTextController.dispose();
    super.dispose();
  }
}
