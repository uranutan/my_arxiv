import 'dart:convert';

import 'package:flutter/material.dart';
import 'topic.dart';
import 'package:flutter/foundation.dart';
import '../services/local_storage.dart';

class TopicsModel extends ChangeNotifier {
  List<Topic> _topicsData;

  //constructors
  TopicsModel(this._topicsData);

  TopicsModel.empty() {
    _topicsData = [];
  }

  List<Topic> get topicsData => _topicsData;

  String get topicsJSON {
    List topicsMap = [];
    _topicsData.forEach((topic) => topicsMap.add(topic.toJson()));

    return jsonEncode(topicsMap);
  }

  void writeTopics() {
    LocalStorage.writeFile(topicsJSON);
  }

  int get listLength => _topicsData.length;

  void loadTopics(List<Topic> topicList) {
    _topicsData.addAll(topicList);
    notifyListeners();
  }

  void addTopic(Topic topic) {
    bool duplicate =
        _topicsData.any((item) => item.subjectCode == topic.subjectCode);
    if (!duplicate) {
      _topicsData.add(topic);
      notifyListeners();
      writeTopics();
    }
  }

  void deleteTopic(Topic topic) {
    _topicsData.removeWhere((item) => item.subjectCode == topic.subjectCode);
    notifyListeners();
    writeTopics();
  }

  //TODO: given a subject code return a hashtag topic Label
  // String topicHashTag(String subjectCode) {}
}
