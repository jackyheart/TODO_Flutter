import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'data_protocol.dart';
import 'todo.dart';

class FirebaseSource implements DataProtocol {
  final _dbRef = FirebaseDatabase.instance.reference();

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> resultList = <Todo>[];
    DataSnapshot snapshot = await _dbRef.orderByChild('timestamp').once();

    Map<dynamic, dynamic> valueMap = snapshot.value;
    if (valueMap != null) {
      var keys = valueMap.keys;
      for (var key in keys) {
        Map<dynamic, dynamic> item = valueMap[key];
        Todo todo = Todo(key, item);
        resultList.add(todo);
      }
    }

    return resultList;
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
  void removeItem(String id) {
    _dbRef.child(id).remove();
  }
}
