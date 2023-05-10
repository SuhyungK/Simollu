import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/searchModel.dart';
import 'package:simollu_front/utils/token.dart';

class SearchViewModel {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  List<SearchModel> _result = [];

  List<SearchModel> get result => _result;

  Future<void> setSearchResult(List<SearchModel> searchResult) async {
    _result = searchResult;
  }

  // search/contains/?description={검색어}&cx={경도}&cy={위도}&size=10
  String keyword = "베트남음식"; // 검색어
  double lat = 37.5013068; // 현재위치 : 위도
  double long = 127.0396597; // 현재위치 : 경도

  Future<List<SearchModel>> getSearchResult() async {
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/restaurant/search/contains?description=${keyword}&cx=${lat.toString()}&cy=${long.toString()}&size=10');
    List<SearchModel> result = [];
    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
      uri);
    print(response);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {
      List<dynamic> res = json.decode(response.body)["result"];
      
      // result = jsonDecode(response.body)["result"].map<SearchModel>( (result) {
      //   return SearchModel.fromMap(result);
      // }).toList();
      
      for(dynamic r in res) {
        result.add(SearchModel.fromJSON(r));
      }
      // print("result :" + jsonDecode(response.body)["result"]);
    }

    return result;
  }
}