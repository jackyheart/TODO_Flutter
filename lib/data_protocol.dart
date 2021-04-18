import 'todo.dart';

abstract class DataProtocol {
  Future<List<Todo>> getTodoList();
  void addItem(String todo);
  void removeItem(String todo);
}
