import 'package:busTransport/components/components.dart';
import 'package:busTransport/models/busModel.dart';
import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class StopCard extends StatelessWidget {
  final Stop stop;
  final bool isFirst;
  final bool isLast;
  final Function onDelete;
  const StopCard(
    this.stop, {
    Key key,
    this.isFirst = false,
    this.isLast = false,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 80,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isLast ? Colors.transparent : Colors.blue[100],
                borderRadius: isFirst
                    ? BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      )
                    : BorderRadius.zero,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleLineText(
                    stop.location,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SingleLineText(
                      stop.time,
                      color: Colors.white,
                      fontSize: secondaryFontSize,
                      fontWeight: secondaryFontWeight,
                    ),
                  ),
                ],
              ),
            ),
            onDelete != null
                ? InkWell(
                    onTap: onDelete,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: red_800,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
