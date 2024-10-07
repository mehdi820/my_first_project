import 'package:hive/hive.dart';
import 'dart:async';

class DBManager {
  static final DBManager _instance = DBManager._internal();
  late Box _box;
  final Completer<void> _completer = Completer<void>();

  factory DBManager() {
    return _instance;
  }

  DBManager._internal();

  Future<void> init() async {
    _box = await Hive.openBox('myBox');
    _completer.complete();
  }

  Future<void> _ensureInitialized() async {
    if (!_completer.isCompleted) {
      await _completer.future;
    }
  }

  Future<void> addData(
      int amount, dynamic description, DateTime date, String type) async {
    await _ensureInitialized();
    var value = {
      "amount": amount,
      "description": description,
      "date": date,
      "type": type
    };
    _box.putAll(value);
  }

  Future<dynamic> getData(String key) async {
    await _ensureInitialized();
    return _box.get(key);
  }

  Future<void> deleteData(String key) async {
    await _ensureInitialized();
    _box.delete(key);
  }
}
