import 'package:flutter/material.dart';
import 'package:simollu_front/views/my_review_widget.dart';
import 'package:simollu_front/views/review_management_star_button.dart';
import 'package:simollu_front/views/writable_review_widget.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

List<String> myReviews = ['리뷰 1', '리뷰 2', '리뷰 3'];
List<String> writableReviews = ['작성 가능 리뷰 1', '작성 가능 리뷰 2'];

class ReviewManagementPage extends StatelessWidget {
  const ReviewManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomTabBar(
          length: 2,
          tabs: ['내 리뷰', '작성 가능 리뷰'],
          tabViews: [MyReview(), WritableReview()],
        ));
  }
}
