import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/restaurantModel.dart';
import '../utils/token.dart';

class MainApi {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<List<RestaurantModel>> getRestaurantList() async {
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/restaurant/main/37.5013068/127.0396597');
    List<RestaurantModel> restaurantNearByList = [];

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        uri
    );

    if (response.statusCode == 200) {
      List<dynamic> res1 = json.decode(utf8.decode(response.bodyBytes))["restaurantNearByList"];
      print('메인화면 api 통신 결과 :');
      for(dynamic r in res1) {
        restaurantNearByList.add(r);
        print(r);
      }
    }

    return restaurantNearByList;
  }
}