import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 100),
          child: Text('검색 결과 page',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
              wordSpacing: 0,
              height: 1.0,
              shadows: [],
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
