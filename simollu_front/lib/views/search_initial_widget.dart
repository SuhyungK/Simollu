import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/services/search_api.dart';
import 'package:simollu_front/viewmodels/search_view_model.dart';
import 'package:simollu_front/views/recent_search_keyword_widget.dart';
import 'package:simollu_front/views/search_hot_keyword_widget.dart';
import 'package:simollu_front/views/search_recommendation_button.dart';
import 'package:simollu_front/views/search_result_page.dart';

import '../models/searchModel.dart';
import '../models/search_hot_keyword_model.dart';

class SearchInitialWidget extends StatefulWidget {
  const SearchInitialWidget({Key? key}) : super(key: key);

  @override
  State<SearchInitialWidget> createState() => _SearchInitialWidgetState();
}
const routeB = "/B";
class _SearchInitialWidgetState extends State<SearchInitialWidget> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  SearchApi searchApi = SearchApi();
  late List<SearchHotKeywordModel> keywordList = [];
  late List<SearchModel> result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
    if (setting.name == routeB) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => SearchResultPage(searchResults: result,), settings: setting);
    }
    else {
      throw Exception('Unknown route: ${setting.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    SearchViewModel searchViewModel = Get.find();

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
            Column(
              children: [
                Visibility(
                  // visible: _hasRecentKeyword,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text('최근 검색어',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        RecentSearchKeywordWidget(),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  color: Colors.white,
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
                              onPressed: () async{
                                print('한식 클릭!!!!!!!!');
                                // 검색 api 연결
                                result = (await searchViewModel.getSearchResult("한식")).cast<SearchModel>();

                                await searchViewModel.setSearchResult(result);

                                // 검색 결과 페이지로 이동
                                _navigatorKey.currentState?.pushNamed(routeB);
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
                  color: Colors.white,
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
                    color: Colors.white,
                    // 실시간 검색어 : 1~5위, 6~10위
                    child: Row(
                      children: [
                        Obx(() => SearchHotKeyword(list:
                        searchViewModel.hotKeywordList.value.isEmpty ? RxList():
                        searchViewModel.hotKeywordList.value.sublist(0,5))),
                        Obx(() => SearchHotKeyword(list:
                        searchViewModel.hotKeywordList.value.isEmpty ? RxList():
                        searchViewModel.hotKeywordList.value.sublist(5))),],
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
