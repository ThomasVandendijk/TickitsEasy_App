import 'package:event_system/components/build_card.dart';
import 'package:event_system/components/popups/sell_popup.dart';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/pages/drawer/drawer.dart';
import 'package:event_system/rest/my_tickets.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';


class MyMarketPlace extends PageClass {
  Future<List<MyAccessToken>> myForSaleTokens;

  MyMarketPlace(){
    String url = getHost() + URLs().mySellTokens;
    this.myForSaleTokens = fetchMyAccessTokens(url);
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  AppBar getAppbar(BuildContext context) {
    return AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text("My MarketPlace"),
        ),
      );
  }

  @override
  Widget getBody(BuildContext context) {
    return Center(
            child: FutureBuilder<List<MyAccessToken>>(
               future: myForSaleTokens, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? MyForSaleTokens(items: snapshot.data): 
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
               },
            ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: getBody(context),
      drawer: AppMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SellDialog()));},
        tooltip: 'Sell ticket',
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}

class MyForSaleTokens extends StatefulWidget{
  List<MyAccessToken> items;
  MyForSaleTokens({this.items});

  @override
  _MyForSaleTokens createState() => _MyForSaleTokens(items: this.items);

}

class _MyForSaleTokens extends State<MyForSaleTokens>{
  List<MyAccessToken> items;
  _MyForSaleTokens({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          MyAccessToken currentAccessToken = items[index];
          return createTicketAnnulationCard(context, currentAccessToken);
        },
    );
  }
}
