import 'package:event_system/rest/migrate.dart';
import 'package:flutter/material.dart';

String leftText = 'Continue';
String rightText = 'Cancel';
String popupTitle = "Swap tickets to this device?";
String popupBody = "This device is not registered as the device which contains the tickets, do you want to swap the tickets to this device?";

showMigrateDialog(BuildContext context, String password){
  Widget _continueButton = FlatButton(
      child: Text(leftText, style: TextStyle(color: Colors.white),),
      onPressed:  () {
        activateMigration(context, password);
      },
      color: Colors.deepOrange,
    );
    Widget _cancelButton = FlatButton(
      child: Text(rightText, style: TextStyle(color: Colors.white),),
      onPressed:  () {Navigator.of(context).pop();},
      color: Colors.deepOrange,
    );

    showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(popupTitle),
        content: Text(popupBody),
        actions: [
          _continueButton,
          _cancelButton,
        ],
      );
    });
}
