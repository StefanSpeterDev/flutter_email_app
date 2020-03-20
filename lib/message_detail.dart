import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String subject;
  final String body;

  const MessageDetail({Key key, this.subject, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.subject)),
        body: Center(
          child: Text(this.body),

        ),
    );
  }
}

