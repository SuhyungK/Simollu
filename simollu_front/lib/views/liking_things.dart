import 'package:flutter/material.dart';

class LikingThings extends StatelessWidget {
  const LikingThings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 170), // marginTop 설정
              // height: 200.0, // 세로 크기
              child: Column(
                children: [
                  Text(
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
                          color: Colors.yellow,
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
                    margin: EdgeInsets.only(top: 20),
                    child: Image.asset('assets/liking-image.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 21.0, right: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            print('독서 클릭!!!!!!!!');
                          },
                          child: Text(
                              '독서',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print('걷기 클릭!!!!!!!!');
                          },
                          child: Text('걷기',
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
                              )
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print('사진 클릭!!!!!!!!');
                          },
                          child: Text('사진',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print('쇼핑 클릭!!!!!!!!');
                          },
                          child: Text('쇼핑',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35.0, right: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            print('노래 클릭!!!!!!!!');
                          },
                          child: Text('노래',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print('휴식 클릭!!!!!!!!');
                          },
                          child: Text('휴식',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print('오락&게임 클릭!!!!!!!!');
                          },
                          child: Text('오락 & 게임',
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
                              side: BorderSide( // 테두리 바꾸는 속성
                                color: Colors.black54,
                                width: 1.0,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
