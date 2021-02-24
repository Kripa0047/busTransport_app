import 'package:busTransport/controllers/global/storageController.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/pages/Dashboard/dashboard.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  @override
  void onInit() {
    super.onInit();
    DT.printYellow("SPLASH CONTROLLER INIT");
  }

  @override
  void onReady() {
    super.onReady();
  }

  void decide() async {
    String token = await Get.find<StorageController>().getToken();
    if (token != null) {
      Get.find<StorageController>().isAdmin.value = true;
    }
    Get.offAll(
      () => Dashboard(),
    );
  }
}
