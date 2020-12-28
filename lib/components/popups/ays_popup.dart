import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/pages/drawer/marketplace.dart';
import 'package:event_system/rest/sell_tokens.dart';
import 'package:flutter/material.dart';


showAYSDialog(BuildContext context, MyAccessToken myAccessToken){
  Widget _continueButton = FlatButton(
      child: Text("continue", style: TextStyle(color: Colors.white),),
      onPressed:  () {
        sellTokens(myAccessToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) => new MyMarketPlace()));
      },
      color: Colors.deepOrange,
    );
    Widget _cancelButton = FlatButton(
      child: Text("cancel", style: TextStyle(color: Colors.white),),
      onPressed:  () {Navigator.of(context).pop();},
      color: Colors.deepOrange,
    );

    showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Are you sure"),
        content: Text("Are you sure you want to sell the ticket for event: " + myAccessToken.title),
        actions: [
          _continueButton,
          _cancelButton,
        ],
      );
    });
}

showCancelDialog(BuildContext context, MyAccessToken myAccessToken){
  Widget _continueButton = FlatButton(
      child: Text("continue", style: TextStyle(color: Colors.white),),
      onPressed:  () {
        cancelSaleToken(myAccessToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) => new MyMarketPlace()));
      },
      color: Colors.deepOrange,
    );
    Widget _cancelButton = FlatButton(
      child: Text("cancel", style: TextStyle(color: Colors.white),),
      onPressed:  () {Navigator.of(context).pop();},
      color: Colors.deepOrange,
    );

    showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Are you sure"),
        content: Text("Are you sure you want to cancel the sale of ticket for event: " + myAccessToken.title),
        actions: [
          _continueButton,
          _cancelButton,
        ],
      );
    });
}