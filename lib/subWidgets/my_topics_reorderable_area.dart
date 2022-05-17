import 'package:flutter/material.dart';
import 'package:my_arxiv/models/topic.dart';
import 'package:my_arxiv/models/topicsModel.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/cupertino.dart';
import 'topic_list_tile.dart';
import '../screens/paper_list_screen.dart';

class MyTopicsReorderableArea extends StatefulWidget {
  @override
  _MyTopicsReorderableAreaState createState() =>
      _MyTopicsReorderableAreaState();
}

class _MyTopicsReorderableAreaState extends State<MyTopicsReorderableArea> {
  List<Topic> myTopics;
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicsModel>(builder: (context, topicsModel, child) {
      myTopics = topicsModel.topicsData;

      return ReorderableListView(
        // clipBehavior: Clip.hardEdge,
        children: [
          for (final topic in myTopics)
            TopicListTile(
                key: ValueKey(topic.subjectCode),
                topic: topic,
                delete: topicsModel.deleteTopic,
                showList: showList),
        ],
        scrollDirection: Axis.vertical,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var selectedTopic = myTopics.removeAt(oldIndex);
            myTopics.insert(newIndex, selectedTopic);
          });
        },
      );
    });
  }
}

void showList(BuildContext context, Topic topic) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PaperListScreen(topic: topic)));
}
