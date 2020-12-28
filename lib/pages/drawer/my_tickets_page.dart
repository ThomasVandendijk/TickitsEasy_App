import 'package:event_system/components/build_card.dart';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/rest/my_tickets.dart';
import 'package:event_system/utils/search.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyTicketsPage extends PageClass{
  Future<List<MyAccessToken>> myAccessTokens; 
  MyTicketsPage(){
    String url = getHost() + URLs().myAccessTokens;
    this.myAccessTokens = fetchMyAccessTokens(url);
  }

  @override
  bool hasDrawer = true;

  @override
  AppBar getAppbar(BuildContext context) =>  AppBar(
            title: Center(
              child: Text("My Tickets", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: MyTicketsSearch());
          },)],);

  @override
  Widget getBody(BuildContext context) {
    return Center(
            child: FutureBuilder<List<MyAccessToken>>(
               future: myAccessTokens, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? MyTicketsPageState(items: snapshot.data): 
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
               },
            ),
        );
  }

}

class MyTicketsPageState extends StatefulWidget{
  List<MyAccessToken> items;
  MyTicketsPageState({this.items});

  @override
  _MyTicketsPageState createState() => _MyTicketsPageState(items: this.items);

}

class _MyTicketsPageState extends State<MyTicketsPageState>{
  List<MyAccessToken> items;
  _MyTicketsPageState({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          MyAccessToken currentAccessToken = items[index];
          return createTicketCard(context, currentAccessToken);
        },
    );
  }
}

