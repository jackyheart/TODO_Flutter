import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data_provider.dart';
import 'firebase_source.dart';
import 'todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(primaryColor: Colors.white),
      home: TodoWidget(),
    );
  }
}

class TodoWidget extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<TodoWidget> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  DataProvider _dataProvider = DataProvider();
  Future<List<Todo>> _todoList;

  TextEditingController _textFieldController = TextEditingController();
  String _inputText = "";

  @override
  void initState() {
    super.initState();
    FirebaseSource fbSource = FirebaseSource();
    _dataProvider = DataProvider.withDataSource(fbSource);
    _todoList = _dataProvider.getTodoList();
  }

  void _showInputDialog(BuildContext context) {
    _displayTextInputDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _buildList(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(List<Todo> data) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: data.length,
      itemBuilder: (context, i) {
        return _buildRow(data[i]);
      },
    );
  }

  Widget _buildRow(Todo todo) {
    final listTile = ListTile(
      title: Text(
        todo.task,
        style: _biggerFont,
      ),
      onTap: () {},
    );

    return Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(),
        onDismissed: (direction) {
          _dataProvider.removeTodoItem(todo.id);
          setState(() {
            _todoList = _dataProvider.getTodoList();
          });
        },
        child: listTile);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Item'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter a To-Do item"),
              onChanged: (val) {
                _inputText = val;
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  _textFieldController.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  _dataProvider.addTodoList(_inputText);
                  _textFieldController.clear();
                  setState(() {
                    _todoList = _dataProvider.getTodoList();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
