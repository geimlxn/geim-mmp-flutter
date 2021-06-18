import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
import 'main_screen.dart';
import 'profile_screen.dart';
import 'form_screen.dart';

class InspectionsScreen extends StatefulWidget {
  static const String id = 'inspection_screen';
  @override
  _InspectionsScreenState createState() => _InspectionsScreenState();
}

class _InspectionsScreenState extends State<InspectionsScreen> {
  PageController _pageController = PageController();

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  int _selectedIndex = 0;
  List<String> _widgetOptions = <String>[
    MainScreen.id,
    InspectionsScreen.id,
    ProfileScreen.id
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, _widgetOptions[index]);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
                //Implement logout functionality
              }),
        ],
        title: Text('Inspection Screen'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _buildListView(context),
      bottomNavigationBar: BottomNavigationBar(
        items: navbar,
        iconSize: 25,
        currentIndex: _selectedIndex,
        onTap:  _onItemTap,
      ),
    );
  }

  List<String> _auditOptions = <String>[
    'Westrock Audit',
    'Westrock Evadale AUdit Example',
    'Westrock St. Paul Audit',
    'Westrock Example',
    'Warehouse Saftety CheckList',
  ];

  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(_auditOptions[index]),
          leading: Icon(Icons.attach_file),
          subtitle: Text('Author: Luke Russell'),
          trailing: Icon(Icons.not_started_outlined),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen()));
          },
        );
      },
    );
  }
}
