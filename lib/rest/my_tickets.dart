import 'dart:io';
import 'package:event_system/model/my_access_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<MyAccessToken> parseMyAccessTokens(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<MyAccessToken>((json) =>MyAccessToken.fromJson(json)).toList(); 
} 
Future<List<MyAccessToken>> fetchMyAccessTokens(String url) async {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: "authToken");
  final response = await http.get(url,
  headers: {
      HttpHeaders.authorizationHeader: 'Token $authToken',
    });  
  if (response.statusCode == 200) { 
    print(response.body);
    return parseMyAccessTokens(response.body); 
  } else { 
    throw Exception('Unable to my tickets from the REST API');
  } 
}