// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/paper.dart';
import "../services/ArxivPaperBloc.dart";
import '../subWidgets/sliver_topic_app_bar.dart';
import '../services/myFunctions.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.searchTerm});
  final String searchTerm;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Paper> searchResultList = [];
  bool isLoading = true;
  var bloc;

  @override
  void initState() {
    super.initState();
    bloc = ArxivPaperBloc(searchTerm: widget.searchTerm);
    _loadNextPage(bloc);
  }

  Future _loadNextPage(ArxivPaperBloc bloc) async {
    List<Paper> nextPage = await bloc.fetchSubjectCode();
    //TODO: this needs to be tested.
    bool isEnd = nextPage == null ? true : false;

    if (this.mounted && !isEnd) {
      setState(() {
        searchResultList.addAll(nextPage);
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
    List<Widget> displaySliverList = [SliverTopicAppBar(widget.searchTerm)];
    displaySliverList
        .addAll(turnPaperListToSlivers(paperList: searchResultList));

    return Scaffold(
      backgroundColor: kWineRed,
      body: SafeArea(
        child: Column(children: [
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
        ]),
      ),
    );
  }
}
