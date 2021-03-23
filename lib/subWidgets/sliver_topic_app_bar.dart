import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../subWidgets/search_bar.dart';

class SliverTopicAppBar extends StatelessWidget {
  SliverTopicAppBar(this.topic);
  final Topic topic;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 10.0,
      expandedHeight: 120.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        centerTitle: true,
        title: Container(
            height: 36.0,
            width: double.infinity,
            //needs a controller managed by its ancestor
            child: SearchBar(topic.subjectCode)),
      ),
      floating: true,
      pinned: false,
      // toolbarHeight: 100.0,
    );
  }
}
// search in ${topic.minorTitle}
