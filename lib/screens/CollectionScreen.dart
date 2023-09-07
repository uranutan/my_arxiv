import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../subWidgets/sliver_topic_app_bar.dart';
import '../models/constants.dart';
import '../services/myFunctions.dart';
import 'package:provider/provider.dart';
import '../models/papersModel.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Paper> paperList;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> displaySliverList = [
      SliverTopicAppBar("Bookmarked Collection"),
    ];


    return Consumer<PapersModel>(builder: (context, papersModel, child) {

      paperList = papersModel.papersData;

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
    });
  }
}
