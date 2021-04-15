class DataProvider {
  final _todoList = <String>[];

  DataProvider() {
    for (int i = 0; i < 3; i++) {
      _todoList.add((i + 1).toString());
    }
  }

  List<String> getTodoList() {
    return _todoList;
  }

  void addTodoList(String todo) {
    _todoList.add(todo);
  }

  void removeTodoItem(String todo) {
    _todoList.remove(todo);
  }
}
