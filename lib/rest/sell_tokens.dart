import 'dart:io';

import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void sellTokens(MyAccessToken myAccessToken) async{
  String url = getHost() + URLs().getSellMySellTokenUrl(myAccessToken);
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: 'authToken');
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
      }
    );
}

void cancelSaleToken(MyAccessToken myAccessToken) async{
  String url = getHost() + URLs().getCancelSaleSellToken(myAccessToken);
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: 'authToken');
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
      }
    );
}