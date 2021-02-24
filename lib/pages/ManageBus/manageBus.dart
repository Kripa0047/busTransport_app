import 'package:busTransport/components/components.dart';
import 'package:busTransport/pages/ManageBus/manageBusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBus extends StatefulWidget {
  ManageBus({Key key}) : super(key: key);

  @override
  _ManageBusState createState() => _ManageBusState();
}

class _ManageBusState extends State<ManageBus> {
  final ManageBusController _manageBusController = ManageBusController();

  @override
  void initState() {
    super.initState();
    _manageBusController.getAllBus();
  }

  Widget _buildCreateBusForm() {
    return CustomContainer(
      child: Column(
        children: [
          TextInput(
            title: "Bus Number",
            controller: _manageBusController.busNumber,
          ),
          SizedBox(
            height: 10,
          ),
          TextInput(
            hintText: "Description",
            controller: _manageBusController.description,
            maxLines: 3,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            child: CustomRaiseButton(
              title: "Add New Bus",
              onTap: () {
                FocusScope.of(context).unfocus();
                _manageBusController.addBus();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuses() {
    return Obx(
      () => Column(
        children: [
          ..._manageBusController.buses.value.reversed?.map(
            (bus) => BusCard(
              bus,
              onDelete: () {
                FocusScope.of(context).unfocus();
                _manageBusController.deleteBus(bus);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Manage Bus",
        ),
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
                      _buildCreateBusForm(),
                      _buildBuses(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
