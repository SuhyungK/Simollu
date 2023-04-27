import 'package:flutter/material.dart';

import '../widgets/custom_appBar.dart';

class WritingReviewPage extends StatelessWidget {
  const WritingReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
        appBar: CustomAppBar(
          title: '리뷰 쓰기',
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
        ),
        body: Container(),
      ),
    );
  }
}
