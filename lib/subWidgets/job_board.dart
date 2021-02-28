import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../services/myFunctions.dart';

class JobBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 130.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print("tapped");
              launchURL("https://austms.org.au/phd-randommatrixtheory/");
            },
            child: Container(
              // width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.fiber_new_rounded,
                    color: Colors.yellowAccent,
                    size: 32.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'PhD Position in Random Matrix Theory \n'
                    'University of Melbourne, Australia',
                    style: TextStyle(fontSize: 14.0, color: kOffWhite),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: kPeachRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
