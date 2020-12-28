import 'package:event_system/rest/cryptography.dart';
import 'package:http/http.dart' as http;
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:event_system/pages/builder/root_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

String registrationUrl = getHost() + URLs().registration;

void register(BuildContext context, String firstName, String lastName, String email, String password) async {
  final storage = new FlutterSecureStorage();
  var responseString = await attemptRegistration(firstName, lastName, email, password);
  if(responseString != null) {
    Map valueMap = json.decode(responseString);
    String authToken = valueMap['key'];
    storage.write(key: "authToken", value: authToken);
    handleKeys(password);
    displayDialog(context, "Successful", "You have succesfully created an account!");
    Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
  }
  else{
    displayDialog(context, "An Error Occurred", "Please try again after some time");
  }
}

Future<String> attemptRegistration(String firstName, String lastName, String email, String password) async {
    String host = getHost();
    var res = await http.post(
      registrationUrl,
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password1": password,
        "password2": password
      }
    );
    if(res.statusCode == 201){
      final storage = new FlutterSecureStorage();
      storage.write(key: "first_name", value: firstName);
      storage.write(key: "last_name", value: lastName);
      storage.write(key: 'email', value: email);
      return res.body;
    } 
    return null;
  }

void displayDialog(BuildContext context, String title, String text) => 
    showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          title: Text(title),
          content: Text(text)
        ),
    );
