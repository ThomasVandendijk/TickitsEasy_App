import 'package:event_system/utils/settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:event_system/rest/login.dart';
import 'package:event_system/pages/builder/root_page.dart';
import 'dart:io';
import 'dart:convert';

void buyToken(BuildContext context, int eventId, int agId, int requestAmount) async {
  var responseString = await attemptBuyToken(eventId, agId, requestAmount);
  if(responseString != null) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
    displayDialog(context, "Congratulations!", "The tickets were bought");
  }
}

Future<String> attemptBuyToken(int eventId, int agId, int requestAmount) async{
  String host = getHost();
  String url = host + URLs().getAccessGroupDetailUrl(eventId, agId);
  final storage = new FlutterSecureStorage();
  var authToken = await storage.read(key: 'authToken');
  print(requestAmount);
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "request_amount": json.encode(requestAmount),
      }
    );
  if(res.statusCode == 201) return res.body;
    return null;
}