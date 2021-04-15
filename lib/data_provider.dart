class DataProvider {
  final _todoList = <String>[];

  List<String> getTodoList() {
    for (int i = 0; i < 10; i++) {
      _todoList.add(i.toString());
    }
    return _todoList;
  }

  void addTodoList(String todo) {
    _todoList.add(todo);
  }

  void removeTodoItem(String todo) {
    _todoList.remove(todo);
  }
}
