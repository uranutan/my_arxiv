import 'package:flutter/material.dart';
import '../models/constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar(this.displayText);
  final String displayText;

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
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search_sharp,
            color: kOpaqueWhite,
            size: 20.0,
          ),
          onPressed: () {
            print("searching...");
          },
        ),
        hintText: 'search in ${widget.displayText}',
        hintStyle: kSearchTextStyle,
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kArXivBlack, width: 0.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kOpaqueWhite, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusColor: Colors.white54,
        contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      ),
    );
  }
}
