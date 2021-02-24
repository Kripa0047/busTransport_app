import 'package:flutter/material.dart';
import 'package:busTransport/components/components.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _buildInputs() {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  title: "Start",
                  enabled: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: ListView(
          children: [
            _buildInputs(),
          ],
        ),
      ),
    );
  }
}
