import 'dart:ui';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/rest/my_tickets.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:event_system/components/build_card.dart';


class SellDialog extends StatefulWidget {

  Future<List<MyAccessToken>> myAccessTokens;

  SellDialog(){
    String url = getHost() + URLs().sellableTokens;
    this.myAccessTokens = fetchMyAccessTokens(url);
  }

  @override
  State<StatefulWidget> createState() => new _SellDialog(myAccessTokens: myAccessTokens);
}

class _SellDialog extends State<SellDialog> {
  Future<List<MyAccessToken>> myAccessTokens;
  _SellDialog({this.myAccessTokens});


  @override
  Widget build(BuildContext context) {
    double screenHeight = (MediaQuery.of(context).size.height);
    double screenWidth = (MediaQuery.of(context).size.width);
    double fraction = 0.8;

    Widget _cancelButton = FlatButton(
      child: Text("cancel", style: TextStyle(color: Colors.white),),
      onPressed:  () {Navigator.of(context).pop();},
      color: Colors.deepOrange,
    );

    return AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(child: Text("Select the ticket to sell")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: 0.6*screenHeight,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Center(
                  child: FutureBuilder<List<MyAccessToken>>(
                    future: myAccessTokens, builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error); 
                        return snapshot.hasData ? MyAccessTokensState(items: snapshot.data): 
                        
                        // return the ListView widget : 
                        Center(child: CircularProgressIndicator()); 
                    },
                  ),
              ),
              ),
            ),
            actions: <Widget>[
              _cancelButton,
            ],);
  }
}

class MyAccessTokensState extends StatefulWidget{
  List<MyAccessToken> items;
  MyAccessTokensState({this.items});

  @override
  _MyAccessTokensState createState() => _MyAccessTokensState(items: this.items);

}

class _MyAccessTokensState extends State<MyAccessTokensState>{
  List<MyAccessToken> items;
  _MyAccessTokensState({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          MyAccessToken currentAccessToken = items[index];
          return createTicketSelectionCard(context, currentAccessToken);
        },
    );
  }
}
