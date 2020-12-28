import 'package:event_system/utils/storage.dart';

class AuthToken {
  static String authToken;

  static getToken() async {
    if (authToken == null) {
      final storage = Storage.getState();
      authToken = await storage.read(key: "authToken");
    }
    return authToken;
  }
}