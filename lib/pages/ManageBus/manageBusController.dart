import 'package:busTransport/components/components.dart';
import 'package:busTransport/controllers/global/storageController.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/models/busModel.dart';
import 'package:busTransport/services/manageBusService.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBusController extends GetxController {
  TextEditingController busNumber = new TextEditingController();
  TextEditingController description = new TextEditingController();
  Rx<List<BusModel>> buses = new Rx<List<BusModel>>([]);
  final ManageBusServices _manageBusServices = new ManageBusServices();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    DT.printYellow("LOGIN CONTROLLER INIT");
  }

  Future getAllBus() async {
    try {
      isLoading.value = true;
      var res = await _manageBusServices.getBuses(
        Get.find<StorageController>().token,
      );
      isLoading.value = false;

      if (res['status']) {
        buses.value = [
          ...res['data']['buses']?.map(
            (bus) => new BusModel.fromJSON(bus ?? {}),
          )
        ];
      } else {
        // Alert.show(res['message'], false);
      }
    } catch (e) {
      isLoading.value = false;
      // Alert.show("Something went wrong", false);
    }
    return null;
  }

  Future addBus() async {
    if (busNumber.text.trim().isEmpty) {
      Alert.show("Bus Number cannot be empty", false);
      return;
    }
    if (description.text.trim().isEmpty) {
      Alert.show("Description cannot be empty", false);
      return;
    }

    try {
      Loader.show();
      var res = await _manageBusServices.addBus(
        Get.find<StorageController>().token,
        busNumber.text.trim(),
        description.text.trim(),
      );
      Loader.remove();

      if (res['status']) {
        buses.value = [
          ...buses.value,
          new BusModel.fromJSON({
            'id': res['data']['id'],
            'busNumber': busNumber.text.trim(),
            'description': description.text.trim(),
          })
        ];
        busNumber.text = "";
        description.text = "";
      } else {
        Alert.show(res['message'], false);
      }
    } catch (e) {
      Loader.remove();
      Alert.show("Something went wrong", false);
    }
    return null;
  }

  void deleteBus(BusModel bus) async {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.8,
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MultiLineText(
                  "Are you sure ?",
                  color: primaryColor,
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomFlatButton(
                        title: "Cancel",
                        onTap: () => Get.back(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomRaiseButton(
                        title: "Delete",
                        color: red_800,
                        onTap: () {
                          Get.back();
                          deleteBusConfirm(bus);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future deleteBusConfirm(BusModel bus) async {
    try {
      Loader.show();
      var res = await _manageBusServices.deleteBus(
        Get.find<StorageController>().token,
        bus.id,
      );
      Loader.remove();

      if (res['status']) {
        buses.value.remove(bus);
        buses.value = [...buses.value];
      } else {
        Alert.show(res['message'], false);
      }
    } catch (e) {
      Loader.remove();
      Alert.show("Something went wrong", false);
    }
    return null;
  }
}
