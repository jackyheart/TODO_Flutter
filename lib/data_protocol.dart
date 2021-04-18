import 'todo.dart';

abstract class DataProtocol {
  Future<List<Todo>> getTodoList();
  void addItem(String task);
  void removeItem(String id);
}
