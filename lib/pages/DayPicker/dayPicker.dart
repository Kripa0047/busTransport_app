import 'package:busTransport/components/appBar/customAppBar.dart';
import 'package:busTransport/components/components.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDayPicker extends StatelessWidget {
  CustomDayPicker({Key key}) : super(key: key);

  final List<Map<String, String>> days = [
    {"name": "Monday", "value": "MON"},
    {"name": "Tuesday", "value": "TUE"},
    {"name": "Wednesday", "value": "WED"},
    {"name": "Thursday", "value": "THUR"},
    {"name": "Friday", "value": "FRI"},
    {"name": "Saturday", "value": "SAT"},
    {"name": "Sunday", "value": "SUN"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Select a day",
          isBack: true,
        ),
        body: ListView(
          children: [
            ...days.map(
              (e) => ListTile(
                onTap: () {
                  Get.back(
                    result: e,
                  );
                },
                title: SingleLineText(
                  e['name'],
                  fontSize: secondaryFontSize,
                  color: primaryColor,
                  fontWeight: secondaryFontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
