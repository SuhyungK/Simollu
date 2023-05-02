import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/views/recent_search_keyword_widget.dart';
import 'package:simollu_front/views/search_hot_keyword_widget.dart';
import 'package:simollu_front/views/search_recommendation_button.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
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
                      onSubmitted: (value) async {
                        // 사용자가 입력한 검색어 처리하는 코드 작성
                        print('사용자 검색 엔터');
                        print(value);

                        // 최근 검색어 저장
                        await RecentSearches.save(value);
                        // setState(() {
                        //   _recentSearches.insert(0, value);
                        // });
                        RecentSearches.printRecentSearches();
                      },
                      // TextField 구성 요소 생략
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
                        Text('최근 검색어',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 90, // 최근 검색어 목록이 표시될 높이를 지정합니다.
                          child: RecentSearchKeywordWidget(),
                        )
                      ],
                    ),
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
                    margin: EdgeInsets.only(top: 25),
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

class RecentSearches {
  static const _key = 'recentSearches';

  // 최근 검색어를 저장하는 메소드
  static Future<void> save(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_key) ?? [];
    recentSearches.insert(0, query); // 새로운 검색어를 최상단에 추가
    await prefs.setStringList(_key, recentSearches);
  }

  // 최근 검색어 목록을 불러오는 메소드
  static Future<List<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // 최근 검색어 목록을 삭제하는 메소드
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // 최근 검색어 목록을 출력하는 메소드
  static Future<void> printRecentSearches() async {
    final recentSearches = await load();
    print('Recent searches:');
    for (final query in recentSearches) {
      print(query);
    }
  }

  // 최근 검색어를 업데이트하는 메소드
  static Future<void> update(String newQuery) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_key) ?? [];

    // // 이전 검색어를 새 검색어로 대체
    // final index = recentSearches.indexOf(oldQuery);
    // if (index != -1) {
    //   recentSearches[index] = newQuery;
    // } else {
    //   // 이전 검색어가 목록에 없으면 새 검색어를 최상단에 추가
    //   recentSearches.insert(0, newQuery);
    // }

    await prefs.setStringList(_key, recentSearches);
  }
}
