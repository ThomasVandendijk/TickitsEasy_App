import 'package:event_system/components/build_card.dart';
import 'package:event_system/model/event.dart';
import 'package:event_system/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/rest/event_factory.dart';
import 'package:event_system/utils/settings.dart';


class EventPage extends PageClass{
  Future<List<Event>> events; 
  EventPage(){
    String url = getHost() + URLs().globalEvents;
    this.events = fetchEvents(url);
  }

  @override
  AppBar getAppbar(BuildContext context) =>  AppBar(
            title: Center(
              child: Text("Events", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: EventSearch());
          },)]);


 /* @override
  Widget getBody(BuildContext context) {
    return EventPageState();
  }*/

  @override
  Widget getBody(BuildContext context) {
    return Center(
            child: FutureBuilder<List<Event>>(
               future: events, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? EventPageState(items: snapshot.data): 
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
               },
            ),
        );
  }

}

class EventPageState extends StatefulWidget{
  List<Event> items;
  EventPageState({this.items});

  @override
  _EventPageState createState() => _EventPageState(items: this.items);

}

class _EventPageState extends State<EventPageState>{
  List<Event> items;
  _EventPageState({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Event currentEvent = items[index];
          return createEventCard(context, currentEvent);
        },
    );
  }

}