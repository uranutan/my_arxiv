import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import 'package:share/share.dart';
import '../services/myFunctions.dart';
import '../subWidgets/optional_field.dart';

class PaperDetailScreen extends StatelessWidget {
  PaperDetailScreen({this.tappedPaper});

  final Paper tappedPaper;

  @override
  Widget build(BuildContext context) {
    final String pdfURL = tappedPaper.pdfLink();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "arXiv:${tappedPaper.arXivIDShort}",
          style: TextStyle(fontSize: 18.0),
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              launchURL(pdfURL);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                  "Check out this paper by ${tappedPaper.displayAuthorsLong}. \n"
                  "${tappedPaper.formattedTitle} \n"
                  "Here is the link ${tappedPaper.arXivID}.\n\n"
                  "Send by My arXiv app. ",
                  subject: 'A nice paper on arXiv ');
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "[Submitted on ${tappedPaper.neatUpdateDate}]",
                      style: TextStyle(
                        color: kArXivBlack,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      tappedPaper.formattedTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      tappedPaper.displayAuthorsLong,
                      style: TextStyle(
                        color: kArXivBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),

                //Display Optional List
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (MapEntry e in tappedPaper.optionalMap.entries)
                        e.value == ""
                            ? Container()
                            : OptionalField(arxivRef: e.key, value: e.value)
                    ]),

                SizedBox(height: 20.0),
                Text(
                  'Abstract',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  tappedPaper.formattedAbstract,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
