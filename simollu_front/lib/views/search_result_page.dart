import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        // padding: EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Container(
              height: 7,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
