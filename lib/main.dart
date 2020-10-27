import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'models/constants.dart';
import 'package:my_arxiv/screens/topics_screen.dart';
import 'models/topicsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopicsModel>(
      create: (context) => TopicsModel.empty(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My arXiv',
        theme: ThemeData(
          //TODO: font type for the entire project

          primaryColor: kMoreClassyRed,
          accentColor: kArXivRed,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TopicsScreen(),
      ),
    );
  }
}
