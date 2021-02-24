import 'package:busTransport/components/components.dart';
import 'package:busTransport/pages/Location/LocationController.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Location extends StatefulWidget {
  Location({Key key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final LocationController _locationController = new LocationController();

  @override
  void initState() {
    super.initState();
    _locationController.getAllLocations();
  }

  Widget _buildSearchAndAdd() {
    return CustomContainer(
      child: Row(
        children: [
          Expanded(
            child: TextInput(
              title: "Location",
              controller: _locationController.location,
              onChange: (val) {
                setState(() {});
              },
            ),
          ),
          SizedBox(
            width: 5,
          ),
          CustomRaiseButton(
            title: "Add",
            onTap: () {
              FocusScope.of(context).unfocus();
              _locationController.addLocation();
            },
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLocations() {
    return Obx(
      () => Column(
        children: [
          ..._locationController.locations.value.reversed?.map(
            (location) => location.name
                    .toLowerCase()
                    .contains(_locationController.location.text.toLowerCase())
                ? CustomContainer(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    blurRadius: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: SingleLineText(
                            location.name?.capitalize,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _locationController.deleteLocation(location);
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: red_800,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
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
          title: "Locations",
        ),
        drawer: CustomDrawer(),
        body: Obx(
          () => _locationController.isLoading.value
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
                    await _locationController.getAllLocations();
                  },
                  child: Column(
                    children: [
                      _buildSearchAndAdd(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _buildLocations(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
