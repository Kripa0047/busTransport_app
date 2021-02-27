import 'package:busTransport/pages/BusDetails/busDetails.dart';
import 'package:busTransport/pages/DayPicker/dayPicker.dart';
import 'package:busTransport/pages/Location/locationController.dart';
import 'package:busTransport/pages/LocationPicker/locationPicker.dart';
import 'package:busTransport/pages/ManageBus/manageBusController.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:busTransport/components/components.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ManageBusController _dashBoardController = new ManageBusController();
  final LocationController _locationController = new LocationController();

  Widget _buildInputs() {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  title: "From",
                  enabled: false,
                  controller: _dashBoardController.from,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => LocationPicker(
                        _locationController,
                      ),
                      transition: Transition.rightToLeft,
                    ).then((value) {
                      if (value != null) {
                        _dashBoardController.from.text = value;
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextInput(
                  title: "To",
                  enabled: false,
                  controller: _dashBoardController.to,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => LocationPicker(
                        _locationController,
                      ),
                      transition: Transition.rightToLeft,
                    ).then((value) {
                      if (value != null) {
                        _dashBoardController.to.text = value;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextInput(
            title: "Day",
            controller: _dashBoardController.day,
            enabled: false,
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(
                () => CustomDayPicker(),
                transition: Transition.rightToLeft,
              ).then((value) {
                if (value != null) {
                  _dashBoardController.day.text = value['name'];
                  _dashBoardController.dayKey = value['value'];
                }
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: CustomRaiseButton(
              title: "Search",
              onTap: () {
                FocusScope.of(context).unfocus();
                _dashBoardController.filterSearch();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBuses() {
    return Obx(
      () => Column(
        children: [
          ..._dashBoardController.buses.value?.map(
            (bus) => BusCard(
              bus,
              onTap: () {
                FocusScope.of(context).unfocus();
                Get.to(
                  () => BusDetails(
                    bus.id,
                    _dashBoardController,
                  ),
                  transition: Transition.rightToLeft,
                );
              },
            ),
          ),
          _dashBoardController.buses.value.isEmpty
              ? Container(
                  child: SingleLineText(
                    "No bus found",
                    color: Colors.grey[400],
                    fontWeight: secondaryFontWeight,
                  ),
                )
              : SizedBox(),
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
        body: RefreshIndicator(
          onRefresh: () async {
            await _dashBoardController.filterSearch();
          },
          child: ListView(
            children: [
              _buildInputs(),
              _buildBuses(),
            ],
          ),
        ),
      ),
    );
  }
}
