import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  Loader.show() {
    Get.dialog(
      Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ),
      ),
      // barrierDismissible: false,
      useSafeArea: true,
    );
  }

  Loader.remove() {
    Get.back();
  }
}
