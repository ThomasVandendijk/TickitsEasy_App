import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget{

  Icon fieldIcon;
  TextFormField textFormField;


  CustomFormField(this.fieldIcon, this.textFormField);

 @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                ),
                child: fieldIcon,
                height: 50,
              ),
              Container(
                
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: 250,
                height: 45,
                   child: this.textFormField
                ),
            ],
          )
      ),
    );
  }
}