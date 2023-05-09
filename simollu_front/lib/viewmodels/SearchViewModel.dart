import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/SearchModel.dart';
import 'package:simollu_front/utils/token.dart';

class SearchViewModel {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  // search/contains/?description={검색어}&cx={경도}&cy={위도}&size=10
  String keyword = "초밥"; // 검색어
  double lat = 37.5013068; // 현재위치 : 위도
  double long = 127.0396597; // 현재위치 : 경도

  Future<List<SearchModel>> getSearchResult() async {
    Uri uri = Uri.parse('http://70.12.246.176:8080/api/search/contains?description=${keyword}&cx=${lat}&cy=${long}&size=10');
    List<SearchModel> result = [];
    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhMGFhZTQ3Yi02ODM0LTQ3MTEtOWQ2ZC03MWQxNGMyYzk4MzAiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4MzcwNjA2MX0.O-k7luYzFPFcEe5ZhXnvRZ1YBh-cT_t-qJ3prDXpRMg"
        },
      uri);
    print(response);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['result'].map<SearchModel>( (article) {
        return SearchModel.fromMap(article);
      }).toList();
    }

    return result;
  }
}