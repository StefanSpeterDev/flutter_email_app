import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageList extends StatefulWidget {

  final String title;


  MessageList({this.title});

  @override
  _MessageListState createState() => _MessageListState();
}


class _MessageListState extends State<MessageList> {
  var messages = const [];

  Future loadMessageList() async {

    var content = await rootBundle.loadString('data/message.json');
    // Translate from json to dart object
    var collection = json.decode(content);

    setState(() {
      messages = collection;
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
            var message = messages[index];

            return ListTile(
              title: Text(message['subject']),
              leading: CircleAvatar(
                child: Text('PJ'),
              ),
              isThreeLine: true,
              subtitle: Text(
                message['body'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }),
    );
  }


}
