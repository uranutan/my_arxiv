import 'package:flutter/material.dart';
import 'package:my_arxiv/models/topicsModel.dart';
import '../models/topic.dart';
import 'package:provider/provider.dart';

class TopicTile extends StatefulWidget {
  TopicTile(this.topic);
  final Topic topic;

  @override
  _TopicTileState createState() => _TopicTileState();
}

class _TopicTileState extends State<TopicTile> {
  bool isTicked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          '${widget.topic.subjectCode}',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
        subtitle: Text('${widget.topic.minorTitle}'),
        dense: true,
        visualDensity: VisualDensity.compact,
        trailing: isTicked ? Icon(Icons.check) : null,
        onTap: () {
          setState(() {
            isTicked = !isTicked;
          });

          if (isTicked) {
            Provider.of<TopicsModel>(context, listen: false)
                .addTopic(widget.topic);
          } else {
            Provider.of<TopicsModel>(context, listen: false)
                .deleteTopic(widget.topic);
          }
        });
  }
}

//
