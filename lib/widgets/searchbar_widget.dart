import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(40.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search for saree',
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0)
              ),
        ),
      ),
    );
  }
}