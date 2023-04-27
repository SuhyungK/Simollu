import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/writing_review_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Container(
        color: Colors.white,
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () {
                print('취향 받기 페이지 이동!!!!!!!!');
                Get.to(LikingThings()); //페이지이동
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide( // 테두리 바꾸는 속성
                    color: Colors.black54,
                    width: 1.0,
                  )),
              child: const Text('취향 받기 페이지',
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
            ),
            OutlinedButton(
              onPressed: () {
                print('리뷰 쓰기 페이지 이동!!!!!!!!');
                Get.to(WritingReviewPage()); //페이지이동
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide( // 테두리 바꾸는 속성
                    color: Colors.black54,
                    width: 1.0,
                  )),
              child: const Text('리뷰쓰기 페이지',
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
            ),
          ],
        ),
      ),
    );
  }
}

