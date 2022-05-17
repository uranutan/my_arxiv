import 'package:flutter/material.dart';
import 'package:my_arxiv/models/papersModel.dart';
// import 'package:flutter/widgets.dart';
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
          fontFamily: 'OpenSans',
          primaryColor: kWineRed,
          highlightColor: kSoftPink,
          // backgroundColor: kOffWhite,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // selectedRowColor: kWineRed,
          appBarTheme: AppBarTheme(
              backgroundColor: kWineRed, centerTitle: true),
          progressIndicatorTheme: ProgressIndicatorThemeData(
              circularTrackColor: kAccentRed,
          color: kWineRed)
        ),
        home: ChangeNotifierProvider<PapersModel>(
         create: (context) => PapersModel(),
         child: TopicsScreen()
        ),
      ),
    );
  }
}
