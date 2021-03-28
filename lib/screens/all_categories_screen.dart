import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../subWidgets/topic_tile.dart';
import '../models/ArxivBrain.dart';

class AllCategoriesScreen extends StatelessWidget {
  final allArxivCategories = ArxivBrain.allTopics;
  final phyTopicMap = ArxivBrain.allPhysicsTopics;

  @override
  Widget build(BuildContext context) {
    final mainTitles = allArxivCategories.keys.toList();
    final List<dynamic> subTitles = allArxivCategories.values.toList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            elevation: 5.0,
            title: Text(
              'All Categories',
            ),
            pinned: false,
            floating: true,
            snap: false,
            shadowColor: kArXivBlack,
            backgroundColor: kWineRed,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return AllPhysicsCategories(phyTopicMap);
                } else {
                  var subjects = subTitles[index];
                  return ExpansionTile(
                    childrenPadding: EdgeInsets.only(left: 20.0),
                    title: Text(mainTitles[index],
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    children: subjects
                        .map<Widget>((item) => TopicTile(item))
                        .toList(),
                  );
                }
              },
              childCount: mainTitles.length,
            ),
          )
        ]));
  }
}

class AllPhysicsCategories extends StatelessWidget {
  AllPhysicsCategories(this.allPhysicsTopicsMap);
  final Map<String, List> allPhysicsTopicsMap;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Physics', style: TextStyle(fontWeight: FontWeight.w700)),
      children: allPhysicsTopicsMap.keys.map<Widget>((item) {
        var topicList = allPhysicsTopicsMap[item];

        return ExpansionTile(
          tilePadding:
              EdgeInsets.only(left: 36.0, right: 15.0, top: 0, bottom: 0),
          title: Text(item,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
          childrenPadding: EdgeInsets.only(left: 20.0),
          children: topicList.map<Widget>((topic) => TopicTile(topic)).toList(),
        );
      }).toList(),
    );
  }
}
