import 'package:email_app/compose_button.dart';
import 'package:email_app/message_detail.dart';
import 'package:flutter/material.dart';
import 'package:email_app/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageList extends StatefulWidget {
  final String title;

  MessageList({this.title});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              var _messages = await Message.browse();
              setState(() {
                messages = _messages;
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('stefanspeter26@gmail.com'),
              accountName: Text('Stefan Speter'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://avatars3.githubusercontent.com/u/32258096?s=460&u=af555943b9efdd29e6e74f6aab41d3fa31cbebc4&v=4"
                ),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('Ajouter un nouveau account...'),
                      );
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              trailing: Chip(
                label: Text("11"),
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                backgroundColor: Colors.blue[100],
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text('Draft'),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archive'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text('Sent'),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Trash'),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child : ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
            ),

            Divider(),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: RefreshProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text("Il y a eu une erreur : ${snapshot.error}");
              var messages = snapshot.data;
              return ListView.separated(
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MessageDetail(
                                      body: message.body,
                                      subject: message.subject,
                                    )));
                      },
                    );
                  });
          }
          return Container(
            width: 0,
          );
        },
      ),
      floatingActionButton: ComposeButton(future),
    );
  }
}
