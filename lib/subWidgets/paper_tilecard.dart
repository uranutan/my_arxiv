import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../screens/paper_detail_screen.dart';
import '../models/constants.dart';

class PaperTileCard extends StatelessWidget {
  const PaperTileCard({
    Key key,
    @required this.paper,
    @required this.index,
  }) : super(key: key);

  final Paper paper;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('[${index + 1}]', style: kTextStylePaperListRow1),
                SizedBox(width: 5.0),
                Text(paper.arXivIDShort, style: kTextStylePaperListRow1),
              ],
            ),
            SizedBox(height: 2.0),
            Text(
              paper.formattedTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15.0),
            ),
            SizedBox(height: 2.0),
            Text(
              paper.displayAuthorsLong,
              style: TextStyle(
                color: kArXivBlue,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        subtitle: Text(paper.displaySubtitle,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 11.0,
            )),
        isThreeLine: true,
        dense: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaperDetailScreen(tappedPaper: paper)));
        },
      ),
    );
  }
}
