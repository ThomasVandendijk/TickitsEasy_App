import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class PrivateKey {
  static final PrivateKey _privateKey = PrivateKey._internal();
  static final Future<BIP32> bip32 = getWalletFromStorage();

  factory PrivateKey() {

    return _privateKey;
  }

  static Future<BIP32> getWalletFromStorage() async {
    final FlutterSecureStorage storage = new FlutterSecureStorage();
    String seedAsString = await storage.read(key: "seed");
    List<int> seedList = json.decode(seedAsString).cast<int>();
    Uint8List seed = Uint8List.fromList(seedList);
    return BIP32.fromSeed(seed);
  }

  PrivateKey._internal();
}