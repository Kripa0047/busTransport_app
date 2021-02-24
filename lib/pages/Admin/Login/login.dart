import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:busTransport/components/components.dart';
import 'package:busTransport/pages/Admin/Login/loginController.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final LoginController _loginController = LoginController();

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            TextInput(
              title: "Email",
              controller: _loginController.email,
            ),
            SizedBox(
              height: 10,
            ),
            TextInput(
              title: "Password",
              obscureText: true,
              controller: _loginController.pass,
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaiseButton(
              title: "Login",
              onTap: () {
                FocusScope.of(context).unfocus();
                _loginController.login();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image.asset(
          logo,
          width: Get.width * 0.35,
        ),
        SizedBox(
          height: 10,
        ),
        SingleLineText(
          appTitle,
          color: primaryColor,
        ),
        SingleLineText(
          appName,
          color: primaryColor,
          fontSize: secondaryFontSize,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isBack: true,
          title: "Admin Login",
        ),
        body: ListView(
          children: [
            _buildBanner(),
            _buildLoginForm(context),
          ],
        ),
      ),
    );
  }
}
