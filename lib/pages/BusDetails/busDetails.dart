import 'package:busTransport/components/appBar/customAppBar.dart';
import 'package:busTransport/components/components.dart';
import 'package:busTransport/debugTool/debugTool.dart';
import 'package:busTransport/models/busModel.dart';
import 'package:busTransport/pages/Location/locationController.dart';
import 'package:busTransport/pages/LocationPicker/locationPicker.dart';
import 'package:busTransport/pages/ManageBus/manageBusController.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class BusDetails extends StatefulWidget {
  final String id;
  final bool isAdmin;
  final ManageBusController controller;
  BusDetails(
    this.id,
    this.controller, {
    Key key,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  final TextEditingController _busNo = TextEditingController();
  final TextEditingController _description = TextEditingController();
  BusModel bus = BusModel.fromJSON({});
  Stop stop = Stop.fromJSON({});
  final TextEditingController _time = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final LocationController _locationController = LocationController();

  @override
  void initState() {
    super.initState();
    initilize();
  }

  void initilize() {
    bus = widget.controller.findBus(widget.id) ?? bus;
    _busNo.text = bus.busNumber;
    _description.text = bus.description;
  }

  Widget _buildDetails() {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            title: "Bus Number",
            controller: _busNo,
            enabled: widget.isAdmin,
            onChange: (val) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextInput(
            hintText: "Description",
            controller: _description,
            maxLines: 3,
            enabled: widget.isAdmin,
            onChange: (val) {
              setState(() {});
            },
          ),
          bus.busNumber != _busNo.text || bus.description != _description.text
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: CustomRaiseButton(
                    title: "Update",
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await widget.controller.updateBus(
                        bus.id,
                        _busNo.text,
                        _description.text,
                      );
                      initilize();
                      setState(() {});
                    },
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              ...["MON", "TUE", "WED", "THUR", "FRI", "SAT", "SUN"].map(
                (day) => widget.isAdmin || bus.days.contains(day)
                    ? InkWell(
                        onTap: () async {
                          if (!widget.isAdmin) return;
                          FocusScope.of(context).unfocus();
                          await widget.controller.updateDays(bus, day);
                          initilize();
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 3, right: 3),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                          decoration: BoxDecoration(
                            color: bus.days.contains(day)
                                ? primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: primaryColor,
                            ),
                          ),
                          child: SingleLineText(
                            day,
                            fontWeight: secondaryFontWeight,
                            fontSize: secondaryFontSize,
                            color: bus.days.contains(day)
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStops() {
    return Column(
      children: [
        SingleLineText(
          "Stops",
          color: primaryColor,
        ),
        SizedBox(
          height: 10,
        ),
        ...bus.stops
            .asMap()
            .map(
              (index, stop) => MapEntry(
                index,
                StopCard(
                  stop,
                  isFirst: index == 0,
                  isLast: index == bus.stops.length - 1,
                  onDelete: widget.isAdmin
                      ? () async {
                          FocusScope.of(context).unfocus();
                          await widget.controller
                              .updateStops(bus, stop, true, index);
                          initilize();
                          setState(() {});
                        }
                      : null,
                ),
              ),
            )
            .values
            .toList(),
        widget.isAdmin
            ? CustomContainer(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextInput(
                            title: "Location",
                            controller: _location,
                            enabled: false,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.to(
                                () => LocationPicker(
                                  _locationController,
                                ),
                                transition: Transition.rightToLeft,
                              ).then((value) {
                                if (value != null) {
                                  DT.printGreen(value);
                                  _location.text = value;
                                  stop.location = value;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextInput(
                            title: "Time",
                            controller: _time,
                            enabled: false,
                            onTap: () async {
                              TimeOfDay time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                _time.text =
                                    '${time.hour < 10 ? '0' + time.hour.toString() : time.hour}:${time.minute < 10 ? '0' + time.minute.toString() : time.minute}';
                                stop.time = _time.text;
                                // setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: CustomRaiseButton(
                        title: "Add",
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await widget.controller
                              .updateStops(bus, stop, false, null);
                          stop = Stop.fromJSON({});
                          _location.text = "";
                          _time.text = "";
                          initilize();
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          isBack: true,
        ),
        body: ListView(
          children: [
            _buildDetails(),
            _buildStops(),
          ],
        ),
      ),
    );
  }
}
