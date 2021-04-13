import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';

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
        title: Text(
          '$heading',
          softWrap: true,
          style: kTextStyleCategory,
        ),
      ),
      floating: true,
      pinned: false,
      // toolbarHeight: 100.0,
    );
  }
}
