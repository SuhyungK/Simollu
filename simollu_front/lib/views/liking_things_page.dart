import 'package:flutter/material.dart';
import 'package:simollu_front/views/liking_things_button.dart';

class LikingThings extends StatelessWidget {
  const LikingThings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          color: Colors.white,
          height: double.infinity,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 170), // marginTop 설정
                  // height: 200.0, // 세로 크기
                  child: Column(
                    children: [
                      const Text(
                        "기다리면서",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "뭐하고 ",
                            style: TextStyle(
                              color: Color(0xFFFFD200),
                              fontSize: 50,
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
                          Text(
                              "싶어?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 50,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                                wordSpacing: 0,
                                height: 1.0,
                                shadows: [],
                                decoration: TextDecoration.none,
                              )
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Image.asset('assets/liking-image.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 21.0, right: 21.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              text: '독서',
                              onPressed: () {
                                print('독서 클릭!!!!!!!!');
                              },
                            ),
                            CustomButton(
                              text: '걷기',
                              onPressed: () {
                                print('걷기 클릭!!!!!!!!');
                              },
                            ),
                            CustomButton(
                              text: '사진',
                              onPressed: () {
                                print('사진 클릭!!!!!!!!');
                              },
                            ),
                            CustomButton(
                              text: '쇼핑',
                              onPressed: () {
                                print('쇼핑 클릭!!!!!!!!');
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              text: '노래',
                              onPressed: () {
                                print('노래 클릭!!!!!!!!');
                              },
                            ),
                            CustomButton(
                              text: '휴식',
                              onPressed: () {
                                print('휴식 클릭!!!!!!!!');
                              },
                            ),
                            CustomButton(
                              text: '오락 & 게임',
                              onPressed: () {
                                print('오락 & 게임 클릭!!!!!!!!');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 160),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {  },
                      child: const Text(
                          '완료',
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
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.yellow
                        backgroundColor: Color(0xFFFFD200)
                      ),
                    ),
                  ),
                ),
                ),
            ],
          ),
        )
    );
  }
}
