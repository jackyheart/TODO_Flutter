import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'data_protocol.dart';

class FirebaseSource implements DataProtocol {
  final _dbRef = FirebaseDatabase.instance.reference();

  @override
  Future<List<String>> getTodoList() async {
    List<String> list = <String>[];
    DataSnapshot snapshot = await _dbRef.once();

    Map<dynamic, dynamic> valueMap = snapshot.value;

    if (valueMap != null) {
      var keys = valueMap.keys;
      for (var key in keys) {
        Map<dynamic, dynamic> item = valueMap[key];
        list.add(item["task"]);
      }
    }

    return list;
  }

  @override
  void addItem(String todo) {
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    //update Firebase
    _dbRef
        .child(timestamp.toString())
        .set({'task': todo, 'datetime': formattedDate, 'timestamp': timestamp});
  }

  @override
  void removeItem(String todo) {
    // _todoList.remove(todo);
  }
}
