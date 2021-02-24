import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:busTransport/components/components.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  Widget _buildCredit() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(5),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MultiLineText(
            "Made with ",
            color: Colors.blue[200],
            fontSize: secondaryFontSize,
            fontWeight: secondaryFontWeight,
          ),
          Icon(
            Icons.favorite,
            color: Colors.red[200],
            size: 18,
          ),
          MultiLineText(
            " and ",
            color: Colors.blue[200],
            fontSize: secondaryFontSize,
            fontWeight: secondaryFontWeight,
          ),
          Icon(
            Icons.code,
            color: Colors.green[200],
            size: 18,
          ),
        ],
      ),
    );
  }

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
                    onTap: () {},
                  ),
                  _buidDrawerItem(
                    title: "Buses",
                    icon: Icons.commute,
                    onTap: () {},
                  ),
                  _buidDrawerItem(
                    title: "Admin",
                    icon: Icons.supervised_user_circle_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          _buildCredit(),
        ],
      ),
    );
  }
}
