import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

    // Fetch data from an online API (using http package)
    http.Response response = await http.get('http://www.mocky.io/v2/5e7385093000007c282e6652');
    String content = response.body;

    // Translate from json to dart object
    List collection = json.decode(content);

    // List<Message> fait référence au fichier Message.
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();
    // On lui indique que collection est une list d'élément définie dans message.dart
    // [1,2,3,4].map((el) => el + 1) --> [2,3,4,5]


    setState(() {
      messages = _messages;
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
