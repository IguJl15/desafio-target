import 'package:desafio_target/src/home/datasource/datasource.dart';
import 'package:desafio_target/src/home/models/info.dart';
import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  final InformationDataSource _dataSource;

  _HomePageStore({required InformationDataSource dataSource}) : _dataSource = dataSource;

  // Estado
  @observable
  ObservableList<Info> itens = ObservableList<Info>();
  @observable
  int? currentEditing;

  @observable
  String newTaskText = "";
  @observable
  String editTaskText = "";

  @computed
  bool get isEditing => currentEditing != null;

  @action
  Future<void> init() async {
    final storedItems = await _dataSource.getAllInfos();

    itens.addAll(storedItems);
  }

  @action
  Future<void> addItemButtonPressed() async {
    final item = Info(description: newTaskText);
    final newItemId = await _dataSource.addInfo(item);

    itens.add(item.copyWith(id: newItemId));

    newTaskText = "";
  }

  @action
  Future<void> finishEditButtonPressed() async {
    if (!isEditing) return;

    final editedItem = itens[currentEditing!].copyWith(description: editTaskText);

    final itemFromDs = await _dataSource.edit(editedItem);

    itens[currentEditing!] = itemFromDs;
    currentEditing = null;
    editTaskText = "";
  }

  @action
  Future<void> removeItemButtonPressed(int index) async {
    if (isEditing) return;

    final itemToRemove = itens[index];

    await _dataSource.removeById(itemToRemove.id);
    itens.removeAt(index);
  }

  @action
  void editButtonPressed(int index) {
    if (isEditing) return;

    currentEditing = index;
    editTaskText = itens[currentEditing!].description;
  }

  @action
  void setNewTaskText(String text) {
    newTaskText = text;
  }

  @action
  void setEditTaskText(String text) {
    editTaskText = text;
  }
}
