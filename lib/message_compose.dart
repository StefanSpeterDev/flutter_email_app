import 'package:email_app/message.dart';
import 'package:flutter/material.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose new message"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  validator: (value) => !value.contains('@')
                      ? "TO field must be a valid email"
                      : null,
                  decoration: InputDecoration(
                      labelText: 'TO',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onSaved: (value) => to = value,
                ),
              ),
              ListTile(
                title: TextFormField(
                  validator: (value) {
                    int len = value.length;
                    if (len == 0) {
                      return "SUBJECT cannot be empty";
                    } else if (len < 4) {
                      return "Subject must be more than 4 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'SUBJECT',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onSaved: (value) => subject = value,
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'BODY',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  maxLines: 8,
                  onSaved: (value) => body = value,
                ),
              ),
              ListTile(
                title: RaisedButton(
                  child: Text('SEND'),
                  onPressed: () {
                    // Si tous les validators passent, on save etc..
                    if (this.key.currentState.validate()) {
                      // Save the form and invok every onSaved() for each field
                      this.key.currentState.save();

                      Message message = Message(subject, body);

                      Navigator.pop(context, message);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
