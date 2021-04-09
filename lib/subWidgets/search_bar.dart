import 'package:flutter/material.dart';
import '../models/constants.dart';
import '../screens/search_screen.dart';

class SearchBar extends StatefulWidget {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SearchScreen(searchTerm: searchController.text),
              ),
            );
          },
          child: Icon(
            Icons.search_sharp,
            color: kOffWhite,
            size: 30.0,
          ),
        ),
        hintText: 'Search Keywords',
        hintStyle: kSearchTextStyle,
        //TODO: focused textStyle?
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38, width: 0.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kOffWhite, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        contentPadding: EdgeInsets.only(left: 25.0),
      ),
    );
  }
}
