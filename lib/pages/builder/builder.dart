import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/pages/bottom_appbar/event_page.dart';
import 'package:flutter/material.dart';


EventPage eventPage = new EventPage();

List<PageClass> pages = [eventPage]; 

class ScreenBuilder{

  Widget getAppbarByIndex(BuildContext context, num index){
    return pages[index].getAppbar(context);
  }

  Widget getBodyByIndex(BuildContext context, num index){
    return pages[index].getBody(context);
  }

}