import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../subWidgets/sliver_topic_app_bar.dart';
import '../models/constants.dart';
import '../services/myFunctions.dart';


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key key}) : super(key: key);

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {

  List<Paper> paperList = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> displaySliverList = [
      SliverTopicAppBar("Bookmarked Collection"),
    ];

    displaySliverList.addAll(turnPaperListToSlivers(paperList: paperList));

    return Scaffold(
      backgroundColor: kWineRed,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                child: CustomScrollView(
                  slivers: displaySliverList,
                ),
                onNotification: (notification) {
                  ScrollMetrics scrollDetail = notification.metrics;

                  if (!isLoading &&
                      scrollDetail.pixels >= scrollDetail.maxScrollExtent) {
                    //curious, changing from == to >= did all the trick, dunno why

                    if (this.mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                  }
                  return true;
                },
              ),
            ),
            Container(
              height: isLoading ? 50.0 : 0,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: kOffWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

