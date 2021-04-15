import 'package:flutter/material.dart';
import 'data_provider.dart';

void main() => runApp(MyApp());

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
  final _dataProvider = DataProvider();
  TextEditingController _textFieldController = TextEditingController();
  String _inputText = "";

  void _showInputDialog(BuildContext context) {
    _displayTextInputDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = _dataProvider.getTodoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
      body: _buildList(data),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(List<String> data) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: data.length,
      itemBuilder: (context, i) {
        return _buildRow(data[i]);
      },
    );
  }

  Widget _buildRow(String todo) {
    final listTile = ListTile(
      title: Text(
        todo,
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
          _dataProvider.removeTodoItem(todo);
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
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  _textFieldController.clear();
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  _dataProvider.addTodoList(_inputText);
                  _textFieldController.clear();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
