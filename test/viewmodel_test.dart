import 'package:test/test.dart';
import 'package:todo_app/data_protocol.dart';
import 'package:todo_app/data_provider.dart';
import 'package:todo_app/todo.dart';

class MockDataSource extends DataProtocol {
  var isGetTodoListCalled = false;
  var isAddItemCalled = false;
  var isRemoveItemCalled = false;

  Future<List<Todo>> getTodoList() {
    isGetTodoListCalled = true;

    Future<List<Todo>> future = Future(() => <Todo>[]);
    return future;
  }

  void addItem(String todo) {
    isAddItemCalled = true;
  }

  void removeItem(String todo) {
    isRemoveItemCalled = true;
  }
}

void main() {
  MockDataSource mockDataSource = MockDataSource();

  test('Test getTodoList', () {
    final provider = DataProvider.withDataSource(mockDataSource);
    provider.getTodoList();
    expect(mockDataSource.isGetTodoListCalled, true);
  });

  test('Test addItem', () {
    final provider = DataProvider.withDataSource(mockDataSource);
    provider.addTodoList("");
    expect(mockDataSource.isAddItemCalled, true);
  });

  test('Test removeItem', () {
    final provider = DataProvider.withDataSource(mockDataSource);
    provider.removeTodoItem("id");
    expect(mockDataSource.isRemoveItemCalled, true);
  });
}
