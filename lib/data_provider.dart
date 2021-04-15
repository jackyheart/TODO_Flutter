class DataProvider {
  final _todoList = <String>[];

  List<String> getTodoList() {
    _todoList.add("A");
    _todoList.add("B");
    _todoList.add("C");
    return _todoList;
  }

  void addTodoList(String todo) {
    _todoList.add(todo);
  }

  void removeTodoItem(String todo) {
    _todoList.remove(todo);
  }
}
