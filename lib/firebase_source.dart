import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

abstract class DataProtocol {
  List<String> getTodoList();
  void addItem(String todo);
  void removeItem(String todo);
}

class FirebaseSource implements DataProtocol {
  final _databaseReference = FirebaseDatabase.instance.reference();
  var _index = 0;

  final _todoList = <String>[];

  FirebaseSource() {
    //init
    for (int i = 0; i < 5; i++) {
      _todoList.add((i + 1).toString());
    }
  }

  @override
  List<String> getTodoList() {
    return _todoList;
  }

  @override
  void addItem(String todo) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    //increment index
    _index++;

    //update Firebase
    _databaseReference
        .child(_index.toString())
        .set({'todo': todo, 'timestamp': formattedDate});
  }

  @override
  void removeItem(String todo) {
    _todoList.remove(todo);
  }
}
