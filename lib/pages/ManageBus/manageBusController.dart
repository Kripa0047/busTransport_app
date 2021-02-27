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
  final TextEditingController from = new TextEditingController();
  final TextEditingController to = new TextEditingController();
  final TextEditingController day = new TextEditingController();
  String dayKey = "";

  @override
  void onInit() {
    super.onInit();
    DT.printYellow("LOGIN CONTROLLER INIT");
  }

  BusModel findBus(String id) {
    BusModel res;
    buses.value?.forEach((bus) {
      if (bus.id == id) res = bus;
    });
    return res;
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

  Future updateBus(String id, String busNumber, String description) async {
    if (busNumber.trim().isEmpty) {
      Alert.show("Bus Number cannot be empty", false);
      return;
    }
    if (description.trim().isEmpty) {
      Alert.show("Description cannot be empty", false);
      return;
    }

    try {
      Loader.show();
      var res = await _manageBusServices.updateBus(
        Get.find<StorageController>().token,
        id,
        busNumber.trim(),
        description.trim(),
      );
      Loader.remove();

      if (res['status']) {
        BusModel bus = findBus(id);
        bus.busNumber = busNumber.trim();
        bus.description = description.trim();
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

  Future updateDays(BusModel bus, String day) async {
    List<String> days = [...bus.days];
    if (days.contains(day))
      days.remove(day);
    else
      days.add(day);

    try {
      Loader.show();
      var res = await _manageBusServices.updateDays(
        Get.find<StorageController>().token,
        bus.id,
        days,
      );
      Loader.remove();

      if (res['status']) {
        BusModel temp = findBus(bus.id);
        temp.days = [...days];
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

  Future updateStops(BusModel bus, Stop stop, bool isDelete, int index) async {
    List<Map<String, String>> stops = [];
    stops = [
      ...bus.stops?.map((stop) => {
            "location": stop.location.toString(),
            "time": stop.time.toString(),
          })
    ];

    if (!isDelete) {
      if (stop.location == "" || stop.location == null) {
        Alert.show("Please select a location", false);
        return;
      }
      if (stop.time == "" || stop.time == null) {
        Alert.show("Please select a time", false);
        return;
      }
      stops.add({
        "location": stop.location.toString(),
        "time": stop.time.toString(),
      });
    } else {
      stops.removeAt(index);
    }

    try {
      Loader.show();
      var res = await _manageBusServices.updateStops(
        Get.find<StorageController>().token,
        bus.id,
        stops,
      );
      Loader.remove();

      if (res['status']) {
        BusModel temp = findBus(bus.id);
        if (isDelete)
          temp.stops.removeAt(index);
        else
          temp.stops.add(stop);
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

  Future filterSearch() async {
    if (from.text == "") {
      Alert.show("Please select a From location", false);
      return;
    }
    if (to.text == "") {
      Alert.show("Please select a To location", false);
      return;
    }
    if (dayKey == "") {
      Alert.show("Please select a day", false);
      return;
    }

    try {
      Loader.show();
      var res = await _manageBusServices.filterSearch(
        from.text,
        to.text,
        dayKey,
      );
      Loader.remove();

      if (res['status']) {
        buses.value = [
          ...res['data']['buses'].map((bus) => BusModel.fromJSON(bus)),
        ];
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
