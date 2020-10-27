import 'package:flutter/material.dart';
import '../models/topic.dart';

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
        title: Text(
          '${topic.minorTitle}',
          softWrap: true,
        ),
      ),
      floating: true,
      pinned: false,
      // toolbarHeight: 100.0,
    );
  }
}
