import 'package:http/http.dart' as http;
import '../models/paper.dart';
import 'package:xml/xml.dart';

//TODO: remove this file; no longer using this file.

Future<List<Paper>> fetchSubjectCode(subjectCode, page) async {
  String arxivURI = "http://arxiv.org/schemas/atom";
  String openSearchURI = "http://a9.com/-/spec/opensearch/1.1/";
  var url =
      "http://export.arxiv.org/api/query?search_query=cat:$subjectCode&start=${page * 100}"
      "&max_results=100&sortBy=submittedDate&sortOrder=descending";

  var searchURL =
      "http://export.arxiv.org/api/query?search_query=cat:math.pr+AND+all:%28jesper+AND+ipsen%29"
      "&start=0&max_results=100&sortBy=submittedDate&sortOrder=descending";

  var response = await http.get(searchURL);
  // var response = await http.get(url);
  //TODO: try-catch block for http request

  if (response.statusCode == 200) {
    final xmlDoc = response.body;
    print(xmlDoc.runtimeType.toString());
    final document = XmlDocument.parse(xmlDoc);

    //TODO: if it is empty, raises StateError
    String totalReturnedPapers = document
        .findAllElements('totalResults', namespace: openSearchURI)
        .first
        .innerText;

    print(totalReturnedPapers);

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
  } else {
    throw Exception('Fail to load data from arXiv. Try Again Later');
    //TODO: handle API request error. let user try again later if connection is not work;
    // or reach the end of list
    //TODO: arXiv return error in first Entry tag summary and link
  }
}
