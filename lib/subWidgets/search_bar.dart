import 'package:flutter/material.dart';

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
      controller: searchController,
      decoration: InputDecoration(hintText: 'search in ${widget.displayText}'),
    );
  }
}
