import 'package:event_system/model/user.dart';
import 'package:event_system/pages/builder/root_page.dart';
import 'package:event_system/pages/drawer/my_tickets_page.dart';
import 'package:event_system/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:event_system/components/drawer_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:event_system/rest/login.dart';

import 'marketplace.dart';


class AppMenu extends StatefulWidget {
  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> {
  int _selectedIndex;
  User currentUser = new User('unknown', 'unknown', 'unknown');

  initState() {
    User loggedInUser;
    createCurrentUser().then((loggedInUser){
      setState(() {
        currentUser = loggedInUser;
      });
    });
  }

  final drawerItems = [
    new DrawerItem("Home", "Home", Icons.home, new RootPage()),
    new DrawerItem("MyTickets", "My Tickets", Icons.theaters, new MyTicketsPage()),
    new DrawerItem("MyMarketPlace", "My Marketplace", Icons.shop, new MyMarketPlace()),
    new DrawerItem("Logout", "Logout", Icons.power_settings_new, new LoginSignUpPage())
    //new DrawerItem("My Settings", Icons.settings, new SettingsPage()),
  ];

  _getDrawerItemScreen(int pos) {
    return drawerItems[_selectedIndex].navigationPage;
  }

  _getDrawerItemName(int pos) {
    return drawerItems[_selectedIndex].itemName;
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_getDrawerItemName(_selectedIndex)=="Logout"){
      logOut(context);
    }
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => _getDrawerItemScreen(_selectedIndex))); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(
          d.title,
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/circle_avatar.png"),
                ),
                accountName: new Text(
                  currentUser.firstName + " " + currentUser.lastName,
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                accountEmail: new Text(
                  currentUser.email,
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                )),
            new Column(children: drawerOptions)
          ],
        ),);
  }

  Future<User> createCurrentUser() async{
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String firstName = await storage.read(key: 'first_name');
    String lastName = await storage.read(key: 'last_name');
    String email = await storage.read(key: 'email');
    if (firstName == null){
      firstName = 'unknown';
    }
    if (lastName == null){
      lastName = 'unknown';
    }
    if (email == null){
      email = 'unknown';
    }
    return User(firstName, lastName, email);
  }
}