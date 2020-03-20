import 'package:email_app/app_drawer.dart';
import 'package:email_app/message_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {},
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Important',
              ),
              Tab(
                text: 'Other',
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
            children: <Widget> [
              MessageList(status:'important'),
              MessageList(status: 'other'),
            ],
        ),
      ),
    );
  }
}
