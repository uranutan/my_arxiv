import 'package:flutter/material.dart';
import 'package:my_arxiv/models/constants.dart';
import '../models/topic.dart';
import 'package:flutter/cupertino.dart';

class TopicListTile extends StatelessWidget {
  const TopicListTile({
    Key key,
    @required this.topic,
    @required this.delete,
    @required this.showList,
  }) : super(key: key);

  final Topic topic;
  final Function delete;
  final Function showList;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: kWineRed,
      color: kOffWhite,
      elevation: 5.0,
      //TODO: onSelect, can I get rid of the shadow
      child: ListTile(
        title: Text(
          '${topic.minorTitle}',
          style: kTextListTileHeading,
        ),
        subtitle: Text('${topic.subjectCode}'),
        dense: true,
        visualDensity: VisualDensity.compact,
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: Text('Delete'),
                    isDestructiveAction: true,
                    onPressed: () {
                      delete(topic);
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        ),
        onTap: () {
          showList(context, topic);
        },
      ),
    );
  }
}
