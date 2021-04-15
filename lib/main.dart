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
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _dataProvider = DataProvider();
  final _saved = <String>{};

  @override
  Widget build(BuildContext context) {
    final data = _dataProvider.getTodoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
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
        });
  }

  Widget _buildRow(String todo) {
    final alreadySaved = _saved.contains(todo);

    final listTile = ListTile(
      title: Text(
        todo,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(todo);
          } else {
            _saved.add(todo);
          }
        });
      },
    );

    return Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(),
        onDismissed: (direction) {
          setState(() {
            _saved.remove(todo);
          });
        },
        child: listTile);
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        final tiles = _saved.map((String todo) {
          return ListTile(
            title: Text(
              todo,
              style: _biggerFont,
            ),
          );
        });

        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      }),
    );
  }
}
