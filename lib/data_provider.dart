import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DataProvider {
  final _todoList = <String>[];
  final _databaseReference = FirebaseDatabase.instance.reference();
  var _index = 0;

  DataProvider() {
    for (int i = 0; i < 5; i++) {
      _todoList.add((i + 1).toString());
    }
  }

  List<String> getTodoList() {
    return _todoList;
  }

  void addTodoList(String todo) {
    _todoList.add(todo);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

    //increment index
    _index++;

    //update Firebase
    _databaseReference
        .child(_index.toString())
        .set({'todo': todo, 'timestamp': formattedDate});
  }

  void removeTodoItem(String todo) {
    _todoList.remove(todo);
  }
}
