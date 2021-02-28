import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import 'package:my_arxiv/models/topicsModel.dart';
import 'package:provider/provider.dart';
import '../subWidgets/my_topics_reorderable_area.dart';
import 'all_categories_screen.dart';
import '../models/topic.dart';
import '../services/local_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_screen.dart';
import '../subWidgets/job_board.dart';

class TopicsScreen extends StatefulWidget {
  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool loading = true;
  bool firstSeen = false;

  GlobalKey _addButton = GlobalKey();

  double positionTop;
  double positionLeft;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPosition();
    });

    super.initState();
    _loadFromFile();
    _numberOfTimesSeen();
  }

  void _getPosition() {
    final RenderBox renderedBox = _addButton.currentContext.findRenderObject();
    final Offset position = renderedBox.localToGlobal(Offset.zero);
    positionTop = position.dy;
    positionLeft = position.dx;
  }

  Future _numberOfTimesSeen() async {
    final SharedPreferences seen = await SharedPreferences.getInstance();
    final int seenTimes = seen.getInt('SeenTimes') ?? 0;
    if (seenTimes == 0) {
      firstSeen = true;
    }
    await seen.setInt('SeenTimes', seenTimes + 1);
  }

  Future _loadFromFile() async {
    final String value = await LocalStorage.readFile();
    List<Topic> savedTopics = [];
    if (value.isNotEmpty) {
      List<dynamic> userTopics = jsonDecode(value);
      userTopics.forEach((item) {
        savedTopics.add(Topic.fromMap(item));
      });
    }
    Provider.of<TopicsModel>(context, listen: false).loadTopics(savedTopics);
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    // final int topicsLength = Provider.of<TopicsModel>(context).listLength;
    List<Widget> stackList = [
      // _MyTopicContent(),
      JobBoard(),
      _MyTopicContent(),
    ];

    if (firstSeen) {
      stackList.addAll([
        OverLayWithHole(
            positionTop: positionTop ?? 0.0, positionLeft: positionLeft ?? 0.0),
        HintTextAddTopic(positionTop ?? 0.0),
      ]);
    }

    return Scaffold(
      backgroundColor: kArXivRed,
      floatingActionButton: FloatingActionButton(
        key: _addButton,
        child: Icon(
          Icons.add,
        ),
        backgroundColor: kArXivRed,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllCategoriesScreen()),
          );
        },
      ),
      body: Stack(children: stackList),
    );
  }
}

class _MyTopicContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 50.0),
        child: Text(
          'My arXiv',
          style: kTextStyleHeading,
        ),
      ),
      SizedBox(height: 80.0),
      Expanded(
        child: Container(
          child: MyTopicsReorderableArea(),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: kOffWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
        ),
      )
    ]));
  }
}
