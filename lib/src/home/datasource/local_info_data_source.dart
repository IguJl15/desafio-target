import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/info.dart';
import 'datasource.dart';

class LocalStorageInfoDataSource implements InformationDataSource {
  static const _keyItems = 'items';
  static const _keyNextId = 'nextId';

  final _prefs = SharedPreferences.getInstance();

  @override
  Future<int> addInfo(Info item) async {
    assert(item.id == 0, "Item já tem um ID atribuído");

    final prefs = await _prefs;
    final nextId = await _getNextId();

    final encodedItems = prefs.getStringList(_keyItems) ?? [];

    encodedItems.add(jsonEncode(
      item.copyWith(id: nextId).toJson(),
    ));

    await prefs.setStringList(_keyItems, encodedItems);

    return nextId;
  }

  @override
  Future<Info> edit(Info item) async {
    assert(item.id != 0, "Item não encontrado");

    final prefs = await _prefs;
    final encodedItems = prefs.getStringList(_keyItems) ?? [];

    final index = encodedItems.indexWhere(
      (encodedItem) => Info.fromJson(jsonDecode(encodedItem)).id == item.id,
    );

    if (index == -1) throw Exception("Item não encontrado");

    encodedItems[index] = jsonEncode(item.toJson());
    await prefs.setStringList(_keyItems, encodedItems);

    return item;
  }

  @override
  Future<List<Info>> getAllInfos() async {
    final prefs = await _prefs;
    final encodedItems = prefs.getStringList(_keyItems) ?? [];
    return encodedItems.map((encodedItem) => Info.fromJson(jsonDecode(encodedItem))).toList();
  }

  @override
  Future<Info> removeById(int id) async {
    final prefs = await _prefs;
    final encodedItems = prefs.getStringList(_keyItems) ?? [];

    final items = encodedItems.map((encodedItem) => Info.fromJson(jsonDecode(encodedItem))).toList();

    final item = items.singleWhere(
      (storedItem) => storedItem.id == id,
      orElse: () => throw Exception("Item não encontrado"),
    );

    items.remove(item);

    await prefs.setStringList(_keyItems, items.map((e) => jsonEncode(e.toJson())).toList());

    return item;
  }

  // Método privado para obter o próximo ID
  Future<int> _getNextId() async {
    final prefs = await _prefs;

    int nextId = (prefs.getInt(_keyNextId) ?? 0) + 1;
    await prefs.setInt(_keyNextId, nextId);

    return nextId;
  }
}
