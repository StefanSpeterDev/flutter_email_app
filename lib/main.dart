import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  var messages = const [
    'My first message',
    'Second message',
    'You have wina  gift',
    'Fourth message',
    'New item added'
  ];

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            var title = messages[index];

            return ListTile(
              title: Text('$title $index'),
              leading: CircleAvatar(
                child: Text('PJ'),
              ),
              isThreeLine: true,
              subtitle: Text(
                  'Another text which is very very long and everyone can read it if they want to'),
            );
          }),
    );
  }
}
