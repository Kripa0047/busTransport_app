import 'package:busTransport/components/components.dart';
import 'package:busTransport/pages/BusDetails/busDetails.dart';
import 'package:busTransport/pages/ManageBus/manageBusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBus extends StatefulWidget {
  AllBus({Key key}) : super(key: key);

  @override
  _AllBusState createState() => _AllBusState();
}

class _AllBusState extends State<AllBus> {
  final ManageBusController _manageBusController = new ManageBusController();

  @override
  void initState() {
    super.initState();
    initilize();
  }

  void initilize() {
    _manageBusController.getAllBus();
  }

  Widget _buildBuses() {
    return Column(
      children: [
        ..._manageBusController.buses.value.reversed?.map(
          (bus) => BusCard(
            bus,
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(
                () => BusDetails(
                  bus.id,
                  _manageBusController,
                ),
                transition: Transition.rightToLeft,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: Obx(
          () => _manageBusController.isLoading.value
              ? Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await _manageBusController.getAllBus();
                  },
                  child: ListView(
                    children: [
                      _buildBuses(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
