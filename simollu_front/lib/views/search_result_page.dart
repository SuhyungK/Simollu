import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  int _numberOfPeople = 1;

  void _incrementNumberOfPeople() {
    setState(() {
      _numberOfPeople++;
    });
  }

  void _decrementNumberOfPeople() {
    if (_numberOfPeople > 1) {
      setState(() {
        _numberOfPeople--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        // padding: EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Container(
              height: 7,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              color: Colors.grey.withOpacity(0.2),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // 위젯 위쪽 정렬
                      children: [
                        SizedBox(
                          // height: 180,
                          child: Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/dongraejeong.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // 이미지가 Container에 꽉 차게 보이도록 설정
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 170,
                                child: Text(
                                  '동래정 선릉직영점rrrrrrrrrrrrrrrrr',
                                  maxLines: 2,
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
                            ],
                          ),
                        ),
                        Expanded(
                          // 나머지 공간을 차지하기 위한 Expanded 위젯
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  Row( // 인원 수, 웨이팅하기 버튼
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: _decrementNumberOfPeople,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 70,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                              child: Text(
                                '$_numberOfPeople',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: _incrementNumberOfPeople,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            print('웨이팅하기 ! 클릭');
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFFFFD200),
                            side: BorderSide(
                              color: Color(0xFFFFD200),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10),
                            child: Text(
                              '웨이팅하기',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 17,
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
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
