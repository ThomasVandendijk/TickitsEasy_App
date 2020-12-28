import 'package:event_system/utils/exceptions.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:event_system/pages/builder/root_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:event_system/rest/migrate.dart';
import 'package:event_system/components/popups/migrate_popup.dart';
import 'dart:convert';

void login(BuildContext context, String email, String password) async {
  final storage = new FlutterSecureStorage();
  var responseString = await attemptLogIn(email, password);
  if(responseString != null) {
    Map valueMap = json.decode(responseString);
    String authToken = valueMap['key'];
    storage.write(key: "authToken", value: authToken);
    storage.write(key: "password", value: password);
    try{
      bool userHasToMigrate = await hasToMigrate();
      if (!userHasToMigrate){
        prefix0.Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
      }
      else{
        showMigrateDialog(context, password);
      }
    }catch(ConnectionException){
      displayDialog(context, "An Error Occurred", "connection error has occured, try again in a few minutes");
    }
  }
  else{
    displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
  }
}

Future<String> attemptLogIn(String email, String password) async {
    String host = getHost();
    print("url " + URLs().login);
    String url = getHost() + URLs().login;
    var res = await http.post(
      url,
      body: {
        "email": email,
        "password": password
      }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }

Future<int> attemptSignUp(String email, String firstName, String lastName, String password) async {
  String host = getHost();
  String url = getHost() + URLs().registration;
  var res = await http.post(
    url,
    body: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password
    }
  );
  return res.statusCode;
  
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

void logOut(BuildContext context) async{
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: "authToken");
  var responseString = await attemptLogout(authToken);
  if(responseString == null) {
    throw new ConnectionException("Something wrong with logging out");
  }
  storage.delete(key: "password");
  storage.delete(key: "authToken");
  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

Future<String> attemptLogout(String authToken) async{
  String host = getHost();
  String url = getHost() + URLs().logout;
  var res = await http.post(
    url,
    );
    if(res.statusCode == 200) return res.body;
    return null;

  }