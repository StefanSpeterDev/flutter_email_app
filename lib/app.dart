import 'package:email_app/calendar_screen.dart';
import 'package:email_app/contact_screens.dart';
import 'package:email_app/inbox_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: [
          InboxScreen(),
          ContactsScreen(),
          CalendarScreen(),
        ].elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('Inbox'),
              icon: Icon(Icons.mail),
            ),
            BottomNavigationBarItem(
              title: Text('Contacts'),
              icon: Icon(Icons.people),
            ),
            BottomNavigationBarItem(
              title: Text('Calendar'),
              icon: Icon(Icons.calendar_today),
            ),
          ],
          onTap: _onBarItemTap,
          currentIndex: _selectedIndex,
        ),
      ),
      length: 2,
    );
  }

  void _onBarItemTap(int value){
    setState(() {
      _selectedIndex = value;
    });
  }
}
