import 'package:my_arxiv/subWidgets/paper_tilecard.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../models/constants.dart';

class StickyHeaderSliverList extends StatelessWidget {
  StickyHeaderSliverList(this.heading, this.subPaperList);

  final String heading;
  final List<Paper> subPaperList;
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: Container(
          decoration: BoxDecoration(
            color: kAccentRed,
            boxShadow: [
              BoxShadow(
                color: kArXivBlack,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          height: 30.0,
          child: Center(
            child: Text(
              heading,
              style: TextStyle(
                  color: kOffWhite,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                PaperTileCard(paper: subPaperList[index], index: index),
            childCount: subPaperList.length,
          ),
        ));
  }
}
