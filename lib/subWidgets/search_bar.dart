import 'package:flutter/material.dart';
import '../models/constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar(this.subjectCode);
  final String subjectCode;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print('${searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kSearchTextStyle,
      controller: searchController,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            print("something");
          },
          child: Icon(
            Icons.search_sharp,
            color: kOpaqueWhite,
            size: 25.0,
          ),
        ),
        hintText: 'Search in ${widget.subjectCode}',
        hintStyle: kSearchTextStyle,
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38, width: 0.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kOffWhite, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: EdgeInsets.only(left: 15.0),
      ),
    );
  }
}
