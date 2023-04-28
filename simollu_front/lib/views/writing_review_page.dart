import 'package:flutter/material.dart';
import 'package:simollu_front/views/writing_review_button.dart';

import '../widgets/custom_appBar.dart';

class WritingReviewPage extends StatelessWidget {
  const WritingReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '리뷰 쓰기',
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/dongraejeong.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover, // 이미지가 Container에 꽉 차게 보이도록 설정
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 19),
                  child: Text(
                      '동래정 선릉직영점',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
                  child: Text(
                    '음식은 어떠셨나요?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Roboto',
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
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    '솔직한 리뷰를 남겨주시면',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Roboto',
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
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    '포크를 드립니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Roboto',
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
                  margin: EdgeInsets.only(top: 50),
                  height: 60,
                  // margin: const EdgeInsets.only(left: 35.0, right: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WritingReviewButton(
                          text: '아쉬워요',
                          onPressed: () {
                            print('아쉬워요 클릭 !');
                            }
                          ),
                      WritingReviewButton(
                          text: '기다릴만해요',
                          onPressed: () {
                            print('기다릴만해요 클릭 !');
                          }
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  margin: EdgeInsets.only(top: 20, left: 19, right: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintText: '음식 맛이나 서비스 만족도에 대해 작성해주세요. (100자 이내)',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                        wordSpacing: 0,
                        height: 1.0,
                        shadows: [],
                        decoration: TextDecoration.none,
                      ),
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 9),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {  },
            style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                // backgroundColor: Colors.yellow
                backgroundColor: Color(0xFFFFD200)
            ),
            child: const Text(
                '작성 완료',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
        ),
      ),
    );
  }
}
