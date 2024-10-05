import 'package:hive/hive.dart';

class DbManager {
  late Box box;

  DbManager() {
    openBox();
  }

  openBox() {
    Hive.box("box");
  }

  Future addData(
      int amount, dynamic description, DateTime date, String type) async {
    var value = {
      "amount": amount,
      "description": description,
      "date": date,
      "type": type
    };
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
