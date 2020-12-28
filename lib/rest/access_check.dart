import 'dart:io';

import 'package:event_system/utils/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String url = getHost() + URLs().accessCheck;

Future<bool> sendAccessCheck(String message, String signature, String publicAddress) async {
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: 'authToken');
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "message": message,
        "signature": signature,
        "public_address": publicAddress,
      }
    );
  return res.statusCode == 200;
}