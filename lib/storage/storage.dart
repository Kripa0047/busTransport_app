import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:busTransport/debugTool/debugTool.dart';

class Storage {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> clearStorage() async {
    await storage.deleteAll();
    return true;
  }

  Future<bool> deleteUserData() async {
    await storage.delete(key: "TOKEN");
    return true;
  }

  Future<bool> storeToken(String token) async {
    await storage.write(key: "TOKEN", value: token);
    return true;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "TOKEN");
    DT.printGreen(token);
    return token;
  }
}
