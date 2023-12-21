import 'package:desafio_target/src/home/models/info.dart';

abstract interface class InformationDataSource {
  /// returns: all stored items in this datasource
  Future<List<Info>> getAllInfos();

  /// returns: the id of the item created
  Future<int> addInfo(Info item);

  /// Remove the item
  /// returns: the item deleted
  Future<Info> removeById(int id);

  /// Remove the item
  /// returns: the item edited. We return the item predicting if the data source implementation modifies any data in the info
  Future<Info> edit(Info item);
}
