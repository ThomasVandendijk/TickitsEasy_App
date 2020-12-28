import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static var storage;

  static getState() async {
    if (storage == null) {
      storage = new FlutterSecureStorage();
    }
    return storage;
  }
}