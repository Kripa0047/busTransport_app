import 'package:busTransport/controllers/global/storageController.dart';
import 'package:busTransport/pages/Admin/Login/login.dart';
import 'package:busTransport/pages/Admin/Login/loginController.dart';
import 'package:busTransport/pages/AllBus/allBus.dart';
import 'package:busTransport/pages/Dashboard/dashboard.dart';
import 'package:busTransport/pages/Location/location.dart';
import 'package:busTransport/pages/ManageBus/manageBus.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:busTransport/components/components.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  Widget _buidDrawerItem({
    String title,
    IconData icon,
    Function onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: primaryColor,
      ),
      title: SingleLineText(
        title,
        color: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  logoSmall,
                  width: 70,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleLineText(
                  appTitle,
                ),
                SingleLineText(
                  appName,
                  fontWeight: secondaryFontWeight,
                  fontSize: secondaryFontSize,
                  color: secondartTextColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buidDrawerItem(
                    title: "Home",
                    icon: Icons.home,
                    onTap: () {
                      Navigator.pop(context);
                      Get.offAll(
                        () => Dashboard(),
                        transition: Transition.fade,
                      );
                    },
                  ),
                  _buidDrawerItem(
                    title: "Buses",
                    icon: Icons.commute,
                    onTap: () {
                      Navigator.pop(context);
                      Get.offAll(
                        () => AllBus(),
                        transition: Transition.fade,
                      );
                    },
                  ),
                  Obx(() {
                    return Get.find<StorageController>().isAdmin.value
                        ? Column(
                            children: [
                              _buidDrawerItem(
                                title: "Add Location",
                                icon: Icons.add_location_alt_rounded,
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.offAll(
                                    () => Location(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                              _buidDrawerItem(
                                title: "Add Bus",
                                icon: Icons.add_road_rounded,
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.offAll(
                                    () => ManageBus(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ],
                          )
                        : _buidDrawerItem(
                            title: "Admin Login",
                            icon: Icons.supervised_user_circle_rounded,
                            onTap: () {
                              Navigator.pop(context);
                              Get.to(
                                () => Login(),
                                transition: Transition.rightToLeft,
                              );
                            },
                          );
                  }),
                ],
              ),
            ),
          ),
          Get.find<StorageController>().isAdmin.value
              ? _buidDrawerItem(
                  title: "Logout",
                  icon: Icons.logout,
                  onTap: () {
                    Navigator.pop(context);
                    LoginController().logout();
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
