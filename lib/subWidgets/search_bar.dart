import 'package:flutter/material.dart';
import '../models/constants.dart';
import '../screens/search_screen.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();
  bool _isEmpty = false;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void handleSearch() {
    setState(() {
      searchController.text.isEmpty ? _isEmpty = true : _isEmpty = false;
    });
    focusNode.unfocus();

    if (!_isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(searchTerm: searchController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kSearchTextStyle,
      controller: searchController,
      cursorColor: kOffWhite,
      autocorrect: false,
      enableSuggestions: false,
      focusNode: focusNode,
      onSubmitted: (String searchValue) {
        handleSearch();
      },
      decoration: InputDecoration(
        suffixIcon: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            handleSearch();
          },
          child: Icon(
            Icons.search_sharp,
            color: kOffWhite,
            size: 30.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        hintText: 'Search Keywords',
        hintStyle: kSearchTextStyle,
        errorText: _isEmpty ? "Cannot be empty" : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        //TODO: focused textStyle?
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kOffWhite, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: EdgeInsets.only(left: 20.0),
      ),
    );
  }
}
