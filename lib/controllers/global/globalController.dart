import 'package:busTransport/controllers/global/storageController.dart';
import 'package:get/get.dart';

class GlobalController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageController>(() => StorageController());
  }
}
