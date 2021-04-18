import 'data_protocol.dart';
import 'todo.dart';

class DataProvider {
  DataProtocol _dataSource;

  DataProvider();

  DataProvider.withDataSource(DataProtocol dataSource) {
    this._dataSource = dataSource;
  }

  Future<List<Todo>> getTodoList() {
    return _dataSource.getTodoList();
  }

  void addTodoList(String todo) {
    _dataSource.addItem(todo);
  }

  void removeTodoItem(String id) {
    _dataSource.removeItem(id);
  }
}
