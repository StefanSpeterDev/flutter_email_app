import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('stefanspeter26@gmail.com'),
            accountName: Text('Stefan Speter'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://avatars3.githubusercontent.com/u/32258096?s=460&u=af555943b9efdd29e6e74f6aab41d3fa31cbebc4&v=4"),
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
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
              labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );

  }
}
