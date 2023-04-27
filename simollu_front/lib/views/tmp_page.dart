import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/writing_review_page.dart';

class TmpPage extends StatelessWidget {
  const TmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {
              print('취향 받기 페이지 이동!!!!!!!!');
              Get.to(LikingThings()); //페이지이동
            },
            child: Text('취향 받기 페이지',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                  wordSpacing: 0,
                  height: 1.0,
                  shadows: [],
                  decoration: TextDecoration.none,
                )),
            style: OutlinedButton.styleFrom(
                side: BorderSide(
              // 테두리 바꾸는 속성
              color: Colors.black54,
              width: 1.0,
            )),
          ),
          OutlinedButton(
            onPressed: () {
              Get.toNamed('/mypage');
            },
            child: Text('마이 페이지'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(WritingReviewPage());
            },
            child: Text('리뷰 쓰기'),
          ),
        ],
      ),
    );
  }
}
