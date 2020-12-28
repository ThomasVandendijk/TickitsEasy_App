import 'package:event_system/components/build_card.dart';
import 'package:event_system/model/access_group.dart';
import 'package:flutter/material.dart';
import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/rest/access_group_factory.dart';
import 'package:event_system/utils/settings.dart';


class AccessGroupPage extends PageClass{
  Future<List<AccessGroup>> access_groups;
  int eventId;
  String eventTitle;
  AccessGroupPage(int eventId, String eventTitle){
    this.eventId = eventId;
    this.eventTitle = eventTitle;
    String url = getHost() + URLs().getAccessGroupUrl(eventId);
    this.access_groups = fetchAccessGroups(url);
  }

  @override
  AppBar getAppbar(BuildContext context) =>  AppBar(
            title: Center(
              child: Text(eventTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
            ),);


 /* @override
  Widget getBody(BuildContext context) {
    return EventPageState();
  }*/

  @override
  Widget getBody(BuildContext context) {
    return Center(
            child: FutureBuilder<List<AccessGroup>>(
               future: access_groups, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? AccessGroupPageState(items: snapshot.data, eventId: eventId,): 
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
               },
            ),
        );
  }

}

class AccessGroupPageState extends StatefulWidget{
  List<AccessGroup> items;
  int eventId;
  AccessGroupPageState({this.items, this.eventId});

  @override
  _AccessGroupPageState createState() => _AccessGroupPageState(items: this.items, eventId: eventId);

}

class _AccessGroupPageState extends State<AccessGroupPageState>{
  List<AccessGroup> items;
  int eventId;
  _AccessGroupPageState({this.items, this.eventId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          AccessGroup currentAccessGroup = items[index];
          return createAccessGroupCard(context, currentAccessGroup, eventId);
        },
    );
  }

}