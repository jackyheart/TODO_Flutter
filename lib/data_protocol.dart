abstract class DataProtocol {
  Future<List<String>> getTodoList();
  void addItem(String todo);
  void removeItem(String todo);
}
