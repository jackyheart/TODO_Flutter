import 'package:todo_app/firebase_source.dart';

class DataProvider {
  DataProtocol _dataSource;

  DataProvider();

  DataProvider.withDataSource(DataProtocol dataSource) {
    this._dataSource = dataSource;
  }

  Future<List<String>> getTodoList() {
    return _dataSource.getTodoList();
  }

  void addTodoList(String todo) {
    _dataSource.addItem(todo);
  }

  void removeTodoItem(String todo) {
    _dataSource.removeItem(todo);
  }
}
