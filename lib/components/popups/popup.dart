import 'dart:ui';
import 'package:event_system/model/access_group.dart';
import 'package:event_system/rest/buy_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomDialog extends StatefulWidget {
  AccessGroup accessGroup;
  int eventId;

  CustomDialog({
    @required this.accessGroup,
    @required this.eventId,
  });

  @override
  State<StatefulWidget> createState() => new _CustomDialog(title:accessGroup.type, buttonText:"BUY", eventId: eventId, agId: accessGroup.id);
}

class _CustomDialog extends State<CustomDialog> {
  final String title, buttonText;
  String dropdownValue = '1';
  int eventId;
  int agId;
  int requestedAmount = 1;
  

  _CustomDialog({
    @required this.title,
    @required this.buttonText,
    @required this.eventId,
    @required this.agId,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.radius),
        ),      
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  Widget getDropDownButton(){
  return DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 15,
    iconEnabledColor: Colors.blue,
    elevation: 16,
    style: TextStyle(
      color: Colors.deepPurple
    ),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String newValue) {
      setState(() {
        requestedAmount = int.parse(newValue);
        dropdownValue = newValue;
      });
    },
    items: <String>['1', '2', '3', '4']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  );
}


dialogContent(BuildContext context) {
  return Stack(
    children: <Widget>[
      getDialogCard(context, title),
      getDialogCircleAvatar(title.substring(0,2).toUpperCase()),
    ],
  );
}


Widget getDialogCard(BuildContext context, String title){
  return Container(
    padding: EdgeInsets.only(
      top: Consts.avatarRadius + Consts.padding,
      bottom: Consts.padding,
      left: Consts.padding,
      right: Consts.padding,
    ),
    margin: EdgeInsets.only(top: Consts.avatarRadius),
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(Consts.padding),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.0),
        Row(children: [
          Text(
          "Select the number of tickets: ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            ),
          ),
          getDropDownButton(),
          ]
        ),
        SizedBox(height: 24.0),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            color: Colors.blue,
            onPressed: () {
              buyToken(context, eventId, agId, requestedAmount);
            },
            child: Text("BUY", style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
    ),
  );
}

  Widget getDialogCircleAvatar(String initials){
    return Positioned(
      left: Consts.padding,
      right: Consts.padding,
      child: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        child: Text(initials,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white), ),
        radius: Consts.avatarRadius,
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 35.0;
  static const double radius = 45.0;
  static const double avatarRadius = 66.0;
}