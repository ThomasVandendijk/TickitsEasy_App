import 'package:event_system/pages/drawer/drawer.dart';
import 'package:flutter/material.dart';

abstract class PageClass extends StatelessWidget{
  Widget getBody(BuildContext context);
  AppBar getAppbar(BuildContext context);
  bool hasDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,
        ),
        Scaffold(
          backgroundColor: Colors.white70,
          appBar: getAppbar(context),
          body: getBody(context),
          drawer: hasDrawer ? AppMenu() : null,
        ),
      ],
    );
  }
} 