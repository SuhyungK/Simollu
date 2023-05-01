import 'package:flutter/material.dart';
import 'package:simollu_front/views/search_hot_keyword_widget.dart';
import 'package:simollu_front/views/search_recommendation_button.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 45,
                  margin: EdgeInsets.only(top: 20, left: 19, right: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        // blurRadius: 3,
                        // offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      alignLabelWithHint: true,
                      // contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintText: '매장을 검색해보세요',
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
                      //
                    ),
                    style: TextStyle(fontSize: 15), // 입력 텍스트 스타일 설정
                  ),
                ),
                Container(
                  height: 7,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Text('추천 검색어',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      Container(
                        margin: const EdgeInsets.only(left: 21.0, right: 21.0, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SearchRecommendationButton(
                              text: '한식',
                              onPressed: () {
                                print('한식 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '양식',
                              onPressed: () {
                                print('양식 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '일식',
                              onPressed: () {
                                print('사진 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '브런치',
                              onPressed: () {
                                print('브런치 클릭!!!!!!!!');
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
                            SearchRecommendationButton(
                              text: '패스트푸드',
                              onPressed: () {
                                print('패스트푸드 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '카페',
                              onPressed: () {
                                print('카페 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '베이커리',
                              onPressed: () {
                                print('베이커리 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '육류',
                              onPressed: () {
                                print('육류 클릭!!!!!!!!');
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
                            SearchRecommendationButton(
                              text: '피자',
                              onPressed: () {
                                print('피자 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '김밥',
                              onPressed: () {
                                print('김밥 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '중식당',
                              onPressed: () {
                                print('중식당 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '다이어트',
                              onPressed: () {
                                print('다이어트 클릭!!!!!!!!');
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
                            SearchRecommendationButton(
                              text: '돼지고기구이',
                              onPressed: () {
                                print('돼지고기구이 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '분식',
                              onPressed: () {
                                print('분식 클릭!!!!!!!!');
                              },
                            ),
                            SearchRecommendationButton(
                              text: '베트남음식',
                              onPressed: () {
                                print('베트남음식 클릭!!!!!!!!');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Text('인기 검색어',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      SearchHotKeyword(),
                      SearchHotKeyword()
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
