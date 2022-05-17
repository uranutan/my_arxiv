import 'package:flutter/foundation.dart';
import 'paper.dart';

class PapersModel extends ChangeNotifier {

  List<Paper> _papersData = [
    Paper(
      arXivID: "2205.07256v1",
      title: "Market-Based Asssets",
      authors: ["Whoever", "ABV"],
      primaryCat: "Math.gm",
      categories: ["Math", "Physics"],
      updatedDate: "May 05 2022",
      publishDate: "May 15 2022",
      abstract: "tell me a story"),
    Paper(arXivID: "2206.05958v1", title: "Investor Attension")
  ];
  //constructors
  PapersModel();
  // PapersModel.empty(){
  // }



  //getters
  List<Paper> get papersData => _papersData;
  int get listLength => _papersData.length;

}