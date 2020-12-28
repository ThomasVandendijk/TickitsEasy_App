import 'package:flutter/material.dart';

class MyAccessToken {
  int id;
  String title;
  String type;
  String date;
  String location;
  String event_image;
  int price;

  MyAccessToken({
    @required this.id,
    @required this.title,
    @required this.type,
    @required this.date,
    @required this.location,
    @required this.event_image,
    @required this.price,
  });

  factory MyAccessToken.fromMap(Map<String, dynamic> json) { 
      return MyAccessToken(
         id: json['id'], 
         title: json['title'], 
         type: json['type'], 
         date: json['date'], 
         location: json['location'],
         event_image: json['event_image'],
         price :json['price'],
      );
   }

   factory MyAccessToken.fromJson(Map<String, dynamic> data) {
   return MyAccessToken(
      id: data['id'], 
      title: data['title'], 
      type: data['type'], 
      date: data['date'], 
      location: data['location'],
      event_image: data['event_image'],
      price :data['price'],
   );
   }
}