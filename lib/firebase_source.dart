import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

abstract class DataProtocol {
  Future<List<String>> getTodoList();
  void addItem(String todo);
  void removeItem(String todo);
}

class FirebaseSource implements DataProtocol {
  final _dbRef = FirebaseDatabase.instance.reference();

  @override
  Future<List<String>> getTodoList() async {
    List<String> list = <String>[];
    DataSnapshot snapshot = await _dbRef.once();

    Map<dynamic, dynamic> valueMap = snapshot.value;

    var keys = valueMap.keys;
    for (var key in keys) {
      Map<dynamic, dynamic> item = valueMap[key];
      list.add(item["task"]);
    }

    return list;
  }

  @override
  void addItem(String todo) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    //update Firebase
    String idFromDate = DateFormat('yyyy-MM-dd-kk:mm:ss').format(now);
    _dbRef.child(idFromDate).set({'task': todo, 'timestamp': formattedDate});
  }

  @override
  void removeItem(String todo) {
    // _todoList.remove(todo);
  }
}
