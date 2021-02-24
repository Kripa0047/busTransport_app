import 'dart:async';
import 'package:get/get.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/storage/storage.dart';

class StorageController extends GetxController {
  String token;
  RxBool isAdmin = false.obs;
  final Storage storage = new Storage();

  @override
  void onInit() async {
    DT.printYellow("STORAGE CONTROLLER INIT");
    await getToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    DT.printYellow("STORAGE CONTROLLER ONREADY");
  }

  Future<String> getToken() async {
    return await storage.getToken().then((value) {
      token = value;
      return value;
    });
  }

  Future<bool> updateToken(String tkn) async {
    await storage.storeToken(tkn).then((value) {
      token = tkn;
    });
    return true;
  }

  Future<bool> logout() async {
    return await storage.deleteUserData().then((value) {
      token = null;
      isAdmin.value = false;
      DT.printYellow("WARNING: USER DATA CLEARED FROM STORE");
      return value;
    });
  }
}
