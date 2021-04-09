import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import "../services/ArxivPaperBloc.dart";
import '../subWidgets/sliver_topic_app_bar.dart';
import '../models/topic.dart';
import '../services/myFunctions.dart';

//Main Class: Future Builder
class PaperListScreen extends StatefulWidget {
  PaperListScreen({this.topic});

  final Topic topic;

  @override
  _PaperListScreenState createState() => _PaperListScreenState();
}

class _PaperListScreenState extends State<PaperListScreen> {
  List<Paper> paperList = [];
  bool isLoading = true;
  var bloc;

  @override
  void initState() {
    super.initState();
    bloc = ArxivPaperBloc(widget.topic.subjectCode);
    _loadNextPage(bloc);
  }

  Future _loadNextPage(bloc) async {
    List<Paper> nextPage = await bloc.fetchSubjectCode();
    bool isEnd = nextPage == null ? true : false;

    if (this.mounted && !isEnd) {
      setState(() {
        paperList.addAll(nextPage);
        isLoading = false;
      });
    }
    if (isEnd) {
      //TODO: get a snackbar to say end of the list/
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> displaySliverList = [
      SliverTopicAppBar(widget.topic.minorTitle)
    ];

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
                    _loadNextPage(bloc);
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
