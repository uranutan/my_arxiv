import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import 'package:share/share.dart';
import '../services/myFunctions.dart';
import '../subWidgets/optional_field.dart';

class PaperDetailScreen extends StatelessWidget {
  PaperDetailScreen({this.tappedPaper});

  final Paper tappedPaper;
  final GlobalKey _shareButton = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final String pdfURL = tappedPaper.pdfLink();
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        title: Center(
          child: GestureDetector(
            child: Text(
              "arXiv:${tappedPaper.arXivIDShort}",
              style: TextStyle(
                fontSize: 18.0,
                color: kOffWhite,
              ),
            ),
            onTap: () {
              launchURL(tappedPaper.arXivID);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.picture_as_pdf,
              color: kOffWhite,
            ),
            onPressed: () {
              launchURL(pdfURL);
            },
          ),
          IconButton(
            key: _shareButton,
            icon: Icon(
              Icons.share,
              color: kOffWhite,
            ),
            onPressed: () {
              final RenderBox box =
                  _shareButton.currentContext.findRenderObject();

              Share.share(
                "${tappedPaper.formattedTitle} @arXiv by ${tappedPaper.displayAuthorsLong}. \n"
                "${tappedPaper.arXivID}\n\n"
                "Send via 'My arXiv' app. ",
                subject: 'A nice paper on arXiv ',
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
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
                        color: kArXivBlack,
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
                    color: kArXivBlack,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  tappedPaper.formattedAbstract,
                  style: TextStyle(
                    color: kArXivBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
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
