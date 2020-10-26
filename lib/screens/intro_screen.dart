import 'package:flutter/material.dart';

class HintTextAddTopic extends StatelessWidget {
  HintTextAddTopic(this.positionTop);
  final positionTop;
  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    // print(screenSize.height);
    return Positioned(
      top: positionTop,
      right: 100.0,
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Text(
              'Add new topics',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward,
                size: 25.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OverLayWithHole extends StatelessWidget {
  OverLayWithHole({this.positionTop, this.positionLeft});

  final double positionTop;
  final double positionLeft;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.black45, BlendMode.srcOut),
      child: Container(
        color: Colors.transparent,
        child: Stack(children: [
          Positioned(
            top: (positionTop - 12.0),
            left: (positionLeft - 12.0),
            child: Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          ),
        ]),
      ),
    );
  }
}
