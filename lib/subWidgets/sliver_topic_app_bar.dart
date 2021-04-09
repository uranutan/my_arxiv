import 'package:flutter/material.dart';

class SliverTopicAppBar extends StatelessWidget {
  SliverTopicAppBar(this.heading);
  final String heading;
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
          child: Text(heading),
        ),
      ),
      floating: true,
      pinned: false,
      // toolbarHeight: 100.0,
    );
  }
}
// search in ${topic.minorTitle}
