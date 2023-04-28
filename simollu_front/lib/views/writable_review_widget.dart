import 'package:flutter/material.dart';
import 'package:simollu_front/views/review_management_star_button.dart';
import 'package:simollu_front/views/writing_review_page.dart';

class WritableReview extends StatelessWidget {
  const WritableReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                    margin: EdgeInsets.only(top: 19),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                      child: Text(
                        '2023-04-12 (수) 19:14',
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
                ],
              ),
            ),
            Expanded( // 나머지 공간을 차지하기 위한 Expanded 위젯
              child: Container(),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 9),
                    // margin: EdgeInsets.only(top: 19),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WritingReviewPage()));
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD200),
                        side: BorderSide(
                          color: Color(0xFFFFD200),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        '리뷰 쓰러가기',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                          wordSpacing: 0,
                          height: 1.0,
                          shadows: [],
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
