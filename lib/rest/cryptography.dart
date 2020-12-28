import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:bip39/bip39.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:bip32/bip32.dart';
import 'package:event_system/utils/bytes_to_hex.dart';

String mnemonicUrl = getHost() + URLs().mnemonicUrl;
String publicAddressUrl = getHost() + URLs().publicAddressUrl;


void handleKeys(String password) async {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: "authToken");
  String mnemonic = await _getMnemonicFromServer(authToken);
  BIP32 bip32 = await createKeys(mnemonic, password);
  storeKeys(bip32);
  Uint8List pubKeyBytes = bip32.publicKey;
  String pubKey = convertUint8ListToHex(pubKeyBytes);
  _postPublicAddressToServer(pubKey, authToken);
}

Future<BIP32> createKeys(String mnemonic, String password) async{
    final storage = new FlutterSecureStorage();
    var seed = mnemonicToSeed(mnemonic, salt:password);
    await storage.write(key: "seed", value: seed.toString());
    var bip32 = BIP32.fromSeed(seed);
    return bip32;
}

void storeKeys(BIP32 bip32) async {
  final storage = new FlutterSecureStorage();
  Uint8List publicAddressBytes = bip32.publicKey;
  Uint8List privateKeyBytes = bip32.privateKey;
  String publicAddress = convertUint8ListToHex(publicAddressBytes);
  String privateKey = convertUint8ListToHex(privateKeyBytes);
    
  await storage.write(key: "privateKey", value: privateKey);
  await storage.write(key: "publicAddress", value: publicAddress);
  
}

Future<String> _getMnemonicFromServer(String authToken) async {
    final response = await http.get(mnemonicUrl,
    headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      });
    if (response.statusCode == 200) { 
      return parseMnemonicResponse(response.body); 
    } else { 
      throw Exception('Unable to get user details from the REST API');
    } 
}

void _postPublicAddressToServer(String publicAddress, String authToken) async{
    final response = await http.put(publicAddressUrl,
    headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "public_address": publicAddress,
      }); 
    if (response.statusCode != 200) {
      throw Exception('Unable to post public address to the REST API');
    }
}


String parseMnemonicResponse(String responseBody){
  Map valueMap = json.decode(responseBody);
  String mnemonic = valueMap['mnemonic'];
  return mnemonic;
}