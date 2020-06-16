import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  // const SearchBar({
  //   Key key,
  // }) : super(key: key);

  final String searchText;
  SearchBar({this.searchText});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(40.0),
        child: TextField(
          onChanged: (String value) {
                
          },
          decoration: InputDecoration(
              hintText: '${widget.searchText}',
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0)
              ),
        ),
      ),
    );
  }
}