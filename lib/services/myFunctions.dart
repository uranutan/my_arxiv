import 'package:url_launcher/url_launcher.dart';
import '../subWidgets/sticky_header_sliver_list.dart';
import 'package:flutter/material.dart';
import '../models/paper.dart';

//Helper functions

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url.';
  }
}

List<Widget> turnPaperListToSlivers({List<Paper> paperList}) {
  var dateList =
      paperList.map((paper) => paper.neatPublishDate).toSet().toList();

  var allSliverList = dateList.map((date) {
    List<Paper> subPaperList =
        paperList.where((paper) => paper.neatPublishDate == date).toList();
    var numberOfSubmissions = subPaperList.length;

    String dateHeading = '$numberOfSubmissions submitted on $date';
    if (date == dateList.last) {
      dateHeading = 'submitted on $date';
    }

    return StickyHeaderSliverList(dateHeading, subPaperList);
  }).toList();

  return allSliverList;
}
