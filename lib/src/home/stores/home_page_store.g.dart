// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  Computed<bool>? _$isEditingComputed;

  @override
  bool get isEditing =>
      (_$isEditingComputed ??= Computed<bool>(() => super.isEditing,
              name: '_HomePageStore.isEditing'))
          .value;

  late final _$itensAtom = Atom(name: '_HomePageStore.itens', context: context);

  @override
  ObservableList<Info> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(ObservableList<Info> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  late final _$currentEditingAtom =
      Atom(name: '_HomePageStore.currentEditing', context: context);

  @override
  int? get currentEditing {
    _$currentEditingAtom.reportRead();
    return super.currentEditing;
  }

  @override
  set currentEditing(int? value) {
    _$currentEditingAtom.reportWrite(value, super.currentEditing, () {
      super.currentEditing = value;
    });
  }

  late final _$newTaskTextAtom =
      Atom(name: '_HomePageStore.newTaskText', context: context);

  @override
  String get newTaskText {
    _$newTaskTextAtom.reportRead();
    return super.newTaskText;
  }

  @override
  set newTaskText(String value) {
    _$newTaskTextAtom.reportWrite(value, super.newTaskText, () {
      super.newTaskText = value;
    });
  }

  late final _$editTaskTextAtom =
      Atom(name: '_HomePageStore.editTaskText', context: context);

  @override
  String get editTaskText {
    _$editTaskTextAtom.reportRead();
    return super.editTaskText;
  }

  @override
  set editTaskText(String value) {
    _$editTaskTextAtom.reportWrite(value, super.editTaskText, () {
      super.editTaskText = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_HomePageStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$addItemButtonPressedAsyncAction =
      AsyncAction('_HomePageStore.addItemButtonPressed', context: context);

  @override
  Future<void> addItemButtonPressed() {
    return _$addItemButtonPressedAsyncAction
        .run(() => super.addItemButtonPressed());
  }

  late final _$finishEditButtonPressedAsyncAction =
      AsyncAction('_HomePageStore.finishEditButtonPressed', context: context);

  @override
  Future<void> finishEditButtonPressed() {
    return _$finishEditButtonPressedAsyncAction
        .run(() => super.finishEditButtonPressed());
  }

  late final _$removeItemButtonPressedAsyncAction =
      AsyncAction('_HomePageStore.removeItemButtonPressed', context: context);

  @override
  Future<void> removeItemButtonPressed(int index) {
    return _$removeItemButtonPressedAsyncAction
        .run(() => super.removeItemButtonPressed(index));
  }

  late final _$_HomePageStoreActionController =
      ActionController(name: '_HomePageStore', context: context);

  @override
  void editButtonPressed(int index) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(
        name: '_HomePageStore.editButtonPressed');
    try {
      return super.editButtonPressed(index);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewTaskText(String text) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(
        name: '_HomePageStore.setNewTaskText');
    try {
      return super.setNewTaskText(text);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditTaskText(String text) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(
        name: '_HomePageStore.setEditTaskText');
    try {
      return super.setEditTaskText(text);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itens: ${itens},
currentEditing: ${currentEditing},
newTaskText: ${newTaskText},
editTaskText: ${editTaskText},
isEditing: ${isEditing}
    ''';
  }
}
