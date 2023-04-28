import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class ReviewManagement extends StatelessWidget {
  const ReviewManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '내 리뷰 관리',
        leading: Image.asset('assets/backBtn.png'),
        actions: [Image.asset('assets/bell.png')],
      ),
      body: CustomTabBar(
          length: 2,
          tabs: ['내 리뷰', '작성 가능 리뷰'],
          tabViews: [],
        )
    );
  }
}
