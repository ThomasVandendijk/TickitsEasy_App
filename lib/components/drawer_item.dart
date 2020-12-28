import 'package:flutter/material.dart';

class DrawerItem {
  String itemName;
  String title;
  IconData icon;
  Widget navigationPage;

  DrawerItem(this.itemName, this.title, this.icon, this.navigationPage);
}