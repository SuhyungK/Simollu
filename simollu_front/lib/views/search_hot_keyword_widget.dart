import 'package:flutter/material.dart';

class SearchHotKeyword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keywordList = [
      {
        "order": 1,
        "keyword": "런던베이글뮤지엄"
      },
      {
        "order": 2,
        "keyword": "바스버거"
      },
      {
        "order": 3,
        "keyword": "동래정"
      },
      {
        "order": 4,
        "keyword": "성심당"
      },
      {
        "order": 5,
        "keyword": "대우부대찌개"
      },
    ];
    final width = MediaQuery.of(context).size.width;
    final halfWidth = width / 2; // 가로 크기와 같은 비율의 높이 계산

    return Container(
      width: halfWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Container',
          //   style: TextStyle(
          //     fontSize: 16.0,
          //     color: Colors.black,
          //   ),
          // ),
          Container(
            height: 190,
            padding: EdgeInsets.only(left: 20),
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Text("${keywordList[index]["order"]}. ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 15,
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
                      margin: EdgeInsets.only(bottom: 25),
                      child: Text("${keywordList[index]["keyword"]}",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 15,
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
                );
              },
            ),
          )
        ]
      ),
    );
  }
}