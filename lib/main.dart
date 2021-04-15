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

  @override
  Widget build(BuildContext context) {
    final data = _dataProvider.getTodoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
      body: _buildList(data),
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
}
