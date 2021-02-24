import 'package:busTransport/components/components.dart';
import 'package:busTransport/controllers/global/storageController.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/models/locationModel.dart';
import 'package:busTransport/services/locationServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  TextEditingController location = new TextEditingController();
  Rx<List<LocationModel>> locations = new Rx<List<LocationModel>>([]);
  final LocationServices _locationServices = new LocationServices();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    DT.printYellow("LOGIN CONTROLLER INIT");
  }

  Future getAllLocations() async {
    try {
      isLoading.value = true;
      var res = await _locationServices.getLocations(
        Get.find<StorageController>().token,
      );
      isLoading.value = false;

      if (res['status']) {
        locations.value = [
          ...res['data']['locations']?.map(
            (location) => new LocationModel.fromJSON(location ?? {}),
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

  Future addLocation() async {
    if (location.text.trim().isEmpty) {
      Alert.show("Enter a location to add", false);
      return;
    }

    try {
      Loader.show();
      var res = await _locationServices.addLocation(
        Get.find<StorageController>().token,
        location.text,
      );
      Loader.remove();

      if (res['status']) {
        locations.value = [
          ...locations.value,
          new LocationModel.fromJSON(res['data'])
        ];
        location.text = "";
      } else {
        Alert.show(res['message'], false);
      }
    } catch (e) {
      Loader.remove();
      Alert.show("Something went wrong", false);
    }
    return null;
  }

  Future deleteLocation(LocationModel location) async {
    try {
      Loader.show();
      var res = await _locationServices.deleteLocation(
        Get.find<StorageController>().token,
        location.id,
      );
      Loader.remove();

      if (res['status']) {
        locations.value.remove(location);
        locations.value = [...locations.value];
        Alert.show("Location removed", true);
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
