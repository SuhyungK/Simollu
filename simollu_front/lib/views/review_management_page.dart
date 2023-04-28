import 'package:flutter/material.dart';
import 'package:simollu_front/views/liking_things_button.dart';
import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/review_management_star_button.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

List<String> myReviews = ['리뷰 1', '리뷰 2', '리뷰 3'];
List<String> writableReviews = ['작성 가능 리뷰 1', '작성 가능 리뷰 2'];

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
          tabViews: [
            myReview(),
            myReview()
          ],
        )
    );
  }

  Widget myReview() {
    return Card(
      elevation: 2.0, //그림자 깊이
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 위젯 위쪽 정렬
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/dongraejeong.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover, // 이미지가 Container에 꽉 차게 보이도록 설정
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '동래정 선릉직영점',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                        wordSpacing: 0,
                        height: 1.0,
                        shadows: [],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                      child: Text(
                        '가나다라마바사아자차카',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          // fontWeight: FontWeight.w600,
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
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    // margin: EdgeInsets.only(top: 19),
                    child: ReviewStarBox(
                      text: '기다릴만해요',
                    )
                  ),
                ],
              ),
            ),
            Expanded( // 나머지 공간을 차지하기 위한 Expanded 위젯
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                '10초 전',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                  wordSpacing: 0,
                  height: 1.0,
                  shadows: [],
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
