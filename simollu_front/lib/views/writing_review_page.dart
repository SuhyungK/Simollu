import 'package:flutter/material.dart';

class WritingReviewPage extends StatelessWidget {
  const WritingReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
        appBar: AppBar(
          title: Text('리뷰 쓰기'),
          centerTitle: true,
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
