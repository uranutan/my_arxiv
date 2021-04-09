import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import "../services/ArxivPaperBloc.dart";
import '../subWidgets/sliver_topic_app_bar.dart';
import '../models/topic.dart';
import '../services/myFunctions.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.searchTerm});
  final String searchTerm;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> displaySliverList = [SliverTopicAppBar(widget.searchTerm)];

    return Scaffold(
      backgroundColor: kWineRed,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: CustomScrollView(
              slivers: displaySliverList,
            ),
          ),
          Container(
            // height: isLoading ? 50.0 : 0,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: kOffWhite,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
