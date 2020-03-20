import 'package:email_app/message_detail.dart';
import 'package:flutter/material.dart';
import 'package:email_app/message.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String status;

  MessageList({this.title, this.status = 'important'});

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
    future = Message.browse(status: widget.status);
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

                  return Slidable(
                    key: ObjectKey(message),
                    delegate: new SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      new IconSlideAction(
                        caption: 'More',
                        onTap: () {},
                        color: Colors.black54,
                        icon: Icons.more_horiz,
                      ),
                      new IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        onTap: () {
                          setState(() {
                            messages.removeAt(index);
                          });
                        },
                        icon: Icons.delete_forever,
                      ),
                    ],
                    child: ListTile(
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
                    ),
                  );
                });
        }
        return Container(
          width: 0,
        );
      },
    );
  }
}
