import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:event_system/pages/builder/root_page.dart';
import 'package:event_system/rest/cryptography.dart';
import 'package:event_system/utils/bytes_to_hex.dart';
import 'package:event_system/utils/exceptions.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String mnemonicUrl = getHost() + URLs().migrateUserDetails;
String migrationPublicAddressUrl = getHost() + URLs().migrateAction;
String deviceStatusUrl = getHost() + URLs().deviceStatus;

Future<bool> hasToMigrate() async{
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: "authToken");
  String publicAddress = await storage.read(key: "publicAddress");
  if (publicAddress == null){
    return Future.value(true);
  }
  String response =  await requestMigrationStatus(authToken, publicAddress);
  if (response == null){
    throw ConnectionException("connection error when requesting migration status");
  } 
  return Future.value(parseResponseMigrationStatus(response));
}

Future<String> requestMigrationStatus(String authToken, String publicAddress) async {
    String host = getHost();
    var res = await http.post(
      deviceStatusUrl,
      headers: {
      HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "public_address": publicAddress
      }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }

bool parseResponseMigrationStatus(String response){
  final parsed = json.decode(response);
  print(parsed);
  int migrationStatus = parsed['status'];
  print('status: ' +  migrationStatus.toString());
  return migrationStatus != 0;
}

void activateMigration(BuildContext context, String password) async{
  FlutterSecureStorage storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: 'authToken');
  String mnemonic = await _getMnemonicAndStoreInfo(authToken, storage);
  BIP32 bip32 = await createKeys(mnemonic, password);
  storeKeys(bip32);
  Uint8List pubKeyBytes = bip32.publicKey;
  String pubKey = convertUint8ListToHex(pubKeyBytes);
  _postMigrationPublicAddressToServer(pubKey, mnemonic, authToken);
  Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));

}

Future<String> _getMnemonicAndStoreInfo(String authToken, FlutterSecureStorage storage) async {
    final response = await http.get(mnemonicUrl,
    headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      });
    if (response.statusCode == 200) {
      _storeUserInfo(response.body, storage);
      return parseMnemonicResponse(response.body); 
    } else { 
      throw Exception('Unable to get user details from the REST API');
    } 
}

void _postMigrationPublicAddressToServer(String publicAddress, String mnemonic, String authToken) async{
    final response = await http.post(migrationPublicAddressUrl,
    headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "public_address": publicAddress,
        "mnemonic": mnemonic,
      }); 
    if (response.statusCode != 200) {
      throw Exception('Unable to post public address to the REST API');
    }
}

void _storeUserInfo(String responseBody, FlutterSecureStorage storage){
  Map valueMap = json.decode(responseBody);
  String first_name = valueMap['first_name'];
  String last_name = valueMap['last_name'];
  String email = valueMap['email'];
  storage.write(key: 'first_name', value: first_name);
  storage.write(key: 'last_name', value: last_name);
  storage.write(key: 'email', value: email);
}

String parseMnemonicResponse(String responseBody){
  Map valueMap = json.decode(responseBody);
  String mnemonic = valueMap['mnemonic'];
  return mnemonic;
}
