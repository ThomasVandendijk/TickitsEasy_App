import 'dart:convert';

import 'package:event_system/pages/drawer/drawer.dart';
import 'package:event_system/rest/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'builder.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  ScreenBuilder _screenBuilder = new ScreenBuilder();

  _RootPageState(){
    /*_canAutoLogin().then((canAutoLogin){
      if (canAutoLogin){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
      }
    });*/
  }

  @override
  void initState() {
    super.initState();
  }
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget get drawer => AppMenu();

  Widget get bottomNavigationBar => BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.black),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Promotions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text('Marketplace'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _screenBuilder.getAppbarByIndex(context, _selectedIndex),
      body: Center(
        child: _screenBuilder.getBodyByIndex(context, _selectedIndex),
      ),
      drawer: drawer,
      //bottomNavigationBar: bottomNavigationBar,
    );
  }

  Future<bool> _canAutoLogin() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String email = await storage.read(key: 'email');
    String password = await storage.read(key: 'password');
    if (email != null && password != null){
      String responseBody = await attemptLogIn(email, password);
      if(responseBody != null){
        Map valueMap = json.decode(responseBody);
        String authToken = valueMap['key'];
        storage.write(key: "authToken", value: authToken);
        return true;
      }
    }
    return false;
  }
}