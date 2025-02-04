import 'dart:async';
import 'package:busTransport/pages/splash/splashController.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashController splashController = SplashController();

  @override
  void initState() {
    super.initState();
    _initilize();
  }

  void _initilize() {
    Timer(
      Duration(seconds: 2),
      () => splashController.decide(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Container(
            child: new Image.asset(
              logo,
              width: Get.width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
