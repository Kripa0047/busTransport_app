import 'package:busTransport/components/components.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  Alert.show(String message, bool isSuccess) {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            width: Get.width * 0.8,
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isSuccess
                      ? "assets/images/checked.png"
                      : "assets/images/cross.png",
                  width: Get.width * 0.15,
                ),
                SizedBox(
                  height: 15,
                ),
                MultiLineText(
                  message ?? "",
                  color: primaryColor,
                  align: TextAlign.center,
                  fontWeight: secondaryFontWeight,
                  fontSize: secondaryFontSize,
                ),
              ],
            ),
          ),
        ),
      ),
      useSafeArea: true,
    );
  }
}
