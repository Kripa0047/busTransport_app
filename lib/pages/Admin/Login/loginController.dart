import 'package:busTransport/components/Alert/alert.dart';
import 'package:busTransport/components/components.dart';
import 'package:busTransport/controllers/global/storageController.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/pages/Dashboard/dashboard.dart';
import 'package:busTransport/services/loginServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final LoginServices _loginServices = new LoginServices();

  @override
  void onInit() {
    super.onInit();
    DT.printYellow("LOGIN CONTROLLER INIT");
  }

  Future login() async {
    if (!RegExp(
      r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$',
    ).hasMatch(email.text)) {
      Alert.show("Please enter a valid email", false);
      return;
    }

    if (pass.text.length < 6) {
      Alert.show("Password must be 6+ characters", false);
      return;
    }

    try {
      Loader.show();
      var res = await _loginServices.login(email.text, pass.text);
      Loader.remove();

      if (res['status']) {
        await Get.find<StorageController>().updateToken(res['data']['token']);
        Get.find<StorageController>().isAdmin.value = true;
        Get.offAll(
          () => Dashboard(),
          transition: Transition.rightToLeft,
        );
      } else {
        Alert.show(res['message'], false);
      }
    } catch (e) {
      Loader.remove();
      Alert.show("Something went wrong", false);
    }
    return null;
  }

  void logout() async {
    try {
      Loader.show();
      bool res = await Get.find<StorageController>().logout();
      Loader.remove();
      if (res) {
        Get.offAll(
          () => Dashboard(),
          transition: Transition.rightToLeft,
        );
      }
    } catch (e) {
      Loader.remove();
    }
  }
}
