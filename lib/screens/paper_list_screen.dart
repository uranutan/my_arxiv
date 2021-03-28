import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import '../services/http_request.dart';
import '../subWidgets/sticky_header_sliver_list.dart';
import '../subWidgets/sliver_topic_app_bar.dart';
import '../models/topic.dart';

//Main Class: Future Builder
class PaperListScreen extends StatefulWidget {
  PaperListScreen({this.topic});

  final Topic topic;

  @override
  _PaperListScreenState createState() => _PaperListScreenState();
}

//TODO: swipe to pop doesn't work for Android
class _PaperListScreenState extends State<PaperListScreen> {
  List<Paper> paperList = [];
  bool isLoading = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  List<Widget> turnPaperListToSlivers(List<Paper> paperList) {
    var dateList =
        paperList.map((paper) => paper.neatPublishDate).toSet().toList();

    var allSliverList = dateList.map((date) {
      List<Paper> subPaperList =
          paperList.where((paper) => paper.neatPublishDate == date).toList();

      var numberOfSubmissions = subPaperList.length;

      String dateHeading = '$numberOfSubmissions submitted on $date';
      if (date == dateList.last) {
        dateHeading = 'submitted on $date';
      }

      return StickyHeaderSliverList(dateHeading, subPaperList);
    }).toList();

    return allSliverList;
  }

  Future _loadNextPage() async {
    List<Paper> nextPage =
        await fetchSubjectCode(widget.topic.subjectCode, page);

    if (this.mounted) {
      setState(() {
        paperList.addAll(nextPage);
        isLoading = false;
        page++;
      });
    }
    //TODO: dealing with end of the list
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> displaySliverList = [SliverTopicAppBar(widget.topic)];

    displaySliverList.addAll(turnPaperListToSlivers(paperList));

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
                    _loadNextPage();
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
