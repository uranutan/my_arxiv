class Paper {
  Paper(
      {this.arXivID,
      this.title,
      this.authors,
      this.primaryCat,
      this.categories,
      this.updatedDate,
      this.publishDate,
      this.abstract,
      this.comment = "",
      this.journalRef = "",
      // ignore: non_constant_identifier_names
      this.DOI = ""});

  String arXivID;
  String title;
  List<String> authors;
  String primaryCat;
  List<String> categories;
  String abstract;
  String updatedDate;
  String publishDate;
  String comment;
  String journalRef;
  // ignore: non_constant_identifier_names
  String DOI;

//TODO: make the values private

  // Getters with formatting
  String get arXivIDShort {
    return arXivID.split("/").last;
  }

  String get neatUpdateDate {
    return updatedDate.split("T").first;
  }

  String get neatPublishDate {
    return publishDate.split("T").first;
  }

  String get formattedTitle {
    return removeLineBreak(title);
  }

  String get displayAuthorsLong {
    var trimmedAuthors = authors.map((element) => element.trim()).toList();
    //TODO:(v2) some authors are way to long, use et al. to shorten it in display

    return trimmedAuthors.join(", ");
  }

  String get formattedAbstract {
    return removeLineBreak(abstract);
  }

  String get neatCategories {
    return sortCategories()['subjects'].join(", ");
  }

  //TODO: (v2) Bold the primary category
  String get mscClasses {
    return removeLineBreak(sortCategories()['msc'].join(""));
  }

  String get acmClasses {
    return removeLineBreak(sortCategories()['acm'].join(""));
  }

  String get neatComment {
    return removeLineBreak(comment);
  }

  String get displaySubtitle {
    if (comment == "") {
      return "Subjects:  $neatCategories";
    } else {
      return "Comments: $neatComment \nSubjects: $neatCategories";
    }
  }

  Map<String, String> get optionalMap {
    Map<String, String> optionalMap = {
      'Comment': neatComment,
      'Subjects': neatCategories,
      'MSC Classes': mscClasses,
      'ACM Classes': acmClasses,
      'DOI': DOI,
      'Journal reference': removeLineBreak(journalRef),
    };

    return optionalMap;
  }

  // Methods

  String pdfLink() {
    var url2 = arXivID.split('/abs/');
    String pdfURL = "${url2.first}/pdf/${url2.last}.pdf";
    return pdfURL;
  }

  String removeLineBreak(String title) {
    var phraseList = title.split("\n").map((element) => element.trim());
    return phraseList.join(" ");
  }

  Map<String, List<String>> sortCategories() {
    Map<String, List<String>> sortedCat = {
      'msc': [],
      'acm': [],
      'subjects': []
    };
    RegExp msc = RegExp(r'\d{2}([A-Z]|\-)\d{2}');
    RegExp acm = RegExp(r'[A-Z]\.([0-9]|\m)');

    categories.asMap().forEach((index, cat) {
      if (msc.hasMatch(cat)) {
        sortedCat['msc'].add(cat);
      } else if (acm.hasMatch(cat)) {
        sortedCat['acm'].add(cat);
      } else {
        sortedCat['subjects'].add(cat);
      }
    });

    return sortedCat;
  }
}
