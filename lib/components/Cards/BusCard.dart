import 'package:busTransport/components/components.dart';
import 'package:busTransport/models/busModel.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusCard extends StatelessWidget {
  final BusModel bus;
  final Function onTap;
  final Function onDelete;
  const BusCard(
    this.bus, {
    Key key,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomContainer(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        blurRadius: 2,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: primaryColor,
                ),
                child: Image.asset(
                  "assets/images/bus.png",
                  width: Get.width * 0.18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleLineText(
                            bus.busNumber,
                            color: primaryColor,
                          ),
                        ),
                        onDelete != null
                            ? InkWell(
                                onTap: onDelete,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: red_800,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleLineText(
                      "Description",
                      color: primaryColor,
                      fontSize: secondaryFontSize,
                    ),
                    MultiLineText(
                      bus.description,
                      color: Colors.grey[600],
                      fontSize: secondaryFontSize,
                      fontWeight: secondaryFontWeight,
                      maxLine: 2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Wrap(
                      children: [
                        ...bus.days?.map(
                          (day) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            margin: EdgeInsets.only(right: 3, top: 3),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleLineText(
                              day,
                              fontSize: secondaryFontSize,
                              fontWeight: secondaryFontWeight,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
