import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/paper.dart';
import 'package:xml/xml.dart';

class ArxivPaperBloc {
  int page = 0;
  int totalNumber = 0;
  String subjectCode;
  String searchTerm;
  bool reachTheEnd = false;

  var client = new http.Client();

  ArxivPaperBloc({this.subjectCode, this.searchTerm});

  String openSearchURI = "http://a9.com/-/spec/opensearch/1.1/";
  String arxivURI = "http://arxiv.org/schemas/atom";
  String baseURL = "http://export.arxiv.org/api/query?search_query=";

  String fetchURLString(String subCode, int startPage, String searchTerm) {
    String sorting =
        "start=${startPage * 100}&max_results=100&sortBy=submittedDate&sortOrder=descending";
    String querySubjectCat = "cat:$subCode";
    String url;
    if (searchTerm != null) {
      String queryAll = searchTerm.trim().split(" ").join('+AND+');
      String querySearch = "all:%28$queryAll%29";
      url = '$baseURL$querySearch&$sorting';
    } else {
      url = '$baseURL$querySubjectCat&$sorting';
    }

    return url;
  }

  Future<List<Paper>> fetchSubjectCode() async {
    String urlString = fetchURLString(subjectCode, page, searchTerm);
    if (!reachTheEnd) {
      final response = await _getPapers(urlString);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          final xmlDoc = response.body;
          final paperList = await _deCodeXMLtoPaperList(xmlDoc);

          if (paperList.length < totalNumber) {
            page++;
          } else {
            page = 0;
            reachTheEnd = true;
          }
          return paperList;
        } else {
          throw Exception("Error: ${response.statusCode}");
        }
      } else if (response is String) {
        throw Exception(response);
        //Unhandled Exception: Exception: Connection closed before full header was received
      } else {
        throw Exception("Fail to load data from arXiv. Please try again.");
      }
    } else {
      print("You have reached the end of the list.");
      // throw Exception("You have reached the end of the list.");
      //TODO: need to end with a return statement.
    }

    //TODO: need to handle all these exceptions.
    //TODO: ResponseState : arXiv return error in first Entry tag summary and link
    //TODO: handle 0 search result
  }

  Future<dynamic> _getPapers(String url) async {
    try {
      var response = await client.get(url);
      return response;
    } on SocketException {
      return "Please check your internet connection.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Paper>> _deCodeXMLtoPaperList(String xmlDoc) async {
    final document = XmlDocument.parse(xmlDoc);
    //TODO: if it is empty, raises StateError
    String totalReturnedPapers = document
        .findAllElements('totalResults', namespace: openSearchURI)
        .first
        .innerText;

    totalNumber = int.parse(totalReturnedPapers);

    var items = document.findAllElements('entry');

    var paperList = items.map((paper) {
      String title = paper.getElement('title').innerText;

      List<String> authors = paper
          .findAllElements('author')
          .map((element) => element.getElement('name').innerText.toString())
          .toList();
      //TODO: affilication of authors?
      List<String> categories = [];
      paper.findAllElements('category').forEach((cat) {
        var attr = cat.attributes;
        attr.forEach((attribute) {
          if (attribute.name.toString() == 'term') {
            categories.add(attribute.value.toString());
          }
        });
      });

      String arXivID = paper.getElement('id').innerText;
      String updatedDate = paper.getElement('updated').text;
      String publishDate = paper.getElement('published').text;
      String abstract = paper.getElement('summary').text;
      String primaryCat = "";
      paper
          .getElement('primary_category', namespace: arxivURI)
          .attributes
          .forEach((ele) {
        if (ele.name.toString() == 'term') {
          primaryCat = ele.value.toString();
        }
      });
      //optional parameters from arXiv nameSpace
      var comment = paper.getElement('comment', namespace: arxivURI);
      // ignore: non_constant_identifier_names
      var DOI = paper.getElement('doi', namespace: arxivURI);
      var journalRef = paper.getElement('journal_ref', namespace: arxivURI);
      //TODO: cited As?
      return Paper(
          arXivID: arXivID,
          title: title,
          authors: authors,
          primaryCat: primaryCat,
          categories: categories,
          updatedDate: updatedDate,
          publishDate: publishDate,
          abstract: abstract,
          comment: comment == null ? "" : comment.text,
          DOI: DOI == null ? "" : DOI.text,
          journalRef: journalRef == null ? "" : journalRef.text);
    }).toList();

    return paperList;
  }

  //TODO: when to call this function to close the connection?
  void closeClient() {
    client.close();
  }
}
