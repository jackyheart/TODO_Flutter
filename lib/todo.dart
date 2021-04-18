class Todo {
  String id;
  String task;
  String datetime;
  int timestamp;

  Todo(String id, Map<dynamic, dynamic> map) {
    this.id = id;
    this.task = map["task"];
    this.datetime = map["datetime"];
    this.timestamp = map["timestamp"];
  }
}
