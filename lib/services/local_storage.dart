import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    final file = File('$path/mytopics.txt');
    if (await file.exists()) {
      return file;
    } else {
      return file.create();
    }
  }

  static Future<String> readFile() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<File> writeFile(String someString) async {
    final file = await _localFile;
    return file.writeAsString(someString);
  }
}
