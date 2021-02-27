import 'package:busTransport/components/appBar/customAppBar.dart';
import 'package:busTransport/components/components.dart';
import 'package:busTransport/pages/Location/locationController.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPicker extends StatefulWidget {
  final LocationController controller;
  const LocationPicker(
    this.controller, {
    Key key,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  void initState() {
    initilize();
    super.initState();
  }

  void initilize() {
    if (widget.controller.locations.value.isEmpty)
      widget.controller.getAllLocations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: CustomAppBar(
            isBack: true,
            title: "Select location",
          ),
          body: widget.controller.isLoading.value
              ? Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : ListView(
                  children: [
                    ...widget.controller.locations.value?.map(
                      (e) => ListTile(
                        onTap: () {
                          Get.back(result: e.name);
                        },
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                        leading: Icon(
                          Icons.location_on,
                          color: primaryColor,
                        ),
                        title: SingleLineText(
                          e.name,
                          color: primaryColor,
                          fontSize: secondaryFontSize,
                          fontWeight: secondaryFontWeight,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
