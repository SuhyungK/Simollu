import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/menuInfoModel.dart';
import 'package:simollu_front/models/restaurantInfoModel.dart';
import '../models/restaurantDetailModel.dart';
import '../models/waitingTimeModel.dart';
import '../utils/token.dart';

class RestaurantDetailApi {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  // https://simollu.com/api/restaurant/124
  Future<RestaurantDetailModel?> getRestaurantDetailInfo(
      int restaurantSeq) async {
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/restaurant/${restaurantSeq}');
    List<MenuInfoModel> menuList = [];
    List<WaitingTimeModel> waitingTimeList = [];
    RestaurantInfoModel r = RestaurantInfoModel(
        restaurantSeq: 0,
        restaurantName: '',
        restaurantAddress: '',
        restaurantBusinessHours: '',
        restaurantPhoneNumber: '',
        restaurantCategory: '',
        restaurantImg: '',
        restaurantRating: 0);
    RestaurantDetailModel result = RestaurantDetailModel(
        restaurantInfo: r, waitingTimeList: [], menuInfoList: []);

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);

    if (response.statusCode == 200) {
      RestaurantInfoModel res1 = RestaurantInfoModel.fromJSON(
          json.decode(utf8.decode(response.bodyBytes))["restaurantInfo"]);
      List<dynamic> res2 =
          json.decode(utf8.decode(response.bodyBytes))["menuInfoList"];
      for (dynamic r in res2) {
        menuList.add(MenuInfoModel.fromJSON(r));
        print(r);
      }
      List<dynamic> res3 =
          json.decode(utf8.decode(response.bodyBytes))["waitingTimeList"];
      for (dynamic r in res3) {
        waitingTimeList.add(WaitingTimeModel.fromJSON(r));
        print(r);
      }

      result = RestaurantDetailModel(
          restaurantInfo: res1,
          menuInfoList: menuList,
          waitingTimeList: waitingTimeList);

      return result;
    }
    return null;
  }
}
