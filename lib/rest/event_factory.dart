import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_system/model/event.dart';

List<Event> parseEvents(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Event>((json) =>Event.fromJson(json)).toList(); 
} 
Future<List<Event>> fetchEvents(String url) async { 
   final response = await http.get(url); 
   if (response.statusCode == 200) { 
      print(response.body);
      return parseEvents(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}
