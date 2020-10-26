class Topic {
  String majorTitle;
  String minorTitle;
  String subjectCode;

  Topic({this.majorTitle, this.minorTitle, this.subjectCode});

  Topic.fromMap(Map<String, dynamic> map) {
    majorTitle = map['majorTitle'];
    minorTitle = map['minorTitle'];
    subjectCode = map['subjectCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'majorTitle': majorTitle,
      'minorTitle': minorTitle,
      'subjectCode': subjectCode,
    };
  }
}
