import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_system/model/access_group.dart';

List<AccessGroup> parseAccessGroups(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<AccessGroup>((json) =>AccessGroup.fromJson(json)).toList(); 
} 
Future<List<AccessGroup>> fetchAccessGroups(String url) async { 
   final response = await http.get(url); 
   if (response.statusCode == 200) { 
      print(response.body);
      return parseAccessGroups(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}