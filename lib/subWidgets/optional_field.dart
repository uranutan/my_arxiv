import 'package:flutter/material.dart';
import '../models/constants.dart';
import '../services/myFunctions.dart';

class OptionalField extends StatelessWidget {
  OptionalField({this.arxivRef, this.value});

  final String arxivRef;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$arxivRef: ',
              style: TextStyle(
                color: kArXivBlack,
                fontSize: 11.0,
              ),
            ),
            Expanded(
                child: arxivRef == 'DOI' && value.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          String url = 'https://dx.doi.org/$value';
                          launchURL(url);
                        },
                        child: Text('$value',
                            style: TextStyle(
                                color: kArXivBlack,
                                fontSize: 11.0,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline)),
                      )
                    : Text('$value',
                        style: TextStyle(color: kArXivBlack, fontSize: 11.0))),
          ],
        ),
        SizedBox(height: 5.0)
      ],
    );
  }
}
