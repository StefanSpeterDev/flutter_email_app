import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_app/message.dart';

class MessageList extends StatefulWidget {
  final String title;

  MessageList({this.title});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<Message> messages = [];

  Future loadMessageList() async {
    String content = await rootBundle.loadString('data/message.json');
    // Translate from json to dart object
    // List<Message> fait référence au fichier Message.
    // On lui indique que collection est une list d'élément définie dans message.dart
    // [1,2,3,4].map((el) => el + 1) --> [2,3,4,5]

    setState(() {
      messages = json
          .decode(content)
          .map((json) => Message.fromJson(json))
          .toList()
          .cast<Message>();
    });
  }

  @override
  void initState() {
    loadMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            // access les fields définis dans Message
            // + safe car on peut appeler uniquement ce qui est définit
            // et si on fait une erreur de typo on sera notifié
            Message message = messages[index];

            return ListTile(
              title: Text(message.subject),
              leading: CircleAvatar(
                child: Text('PJ'),
              ),
              isThreeLine: true,
              subtitle: Text(
                message.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }),
    );
  }
}
