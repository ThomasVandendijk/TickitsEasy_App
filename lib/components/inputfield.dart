import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget{

  Icon fieldIcon;
  String hintText;
  bool obscureText;
  TextEditingController controller;


  CustomInputField(this.fieldIcon,this.hintText, this.obscureText, this.controller);

 @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: fieldIcon,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                ),
                width: 250,
                height: 45,
                  child: TextField(
                    controller: controller,
                    obscureText: this.obscureText,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        fillColor: Colors.white,
                        filled: true
                    ),
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black
                    ),
                  ),
                ),
            ],
          )
      ),
    );
  }
}