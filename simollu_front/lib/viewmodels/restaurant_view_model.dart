import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/utils/token.dart';

class RestaurantViewModel {
  late String token;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  // 식당 리뷰들 조회
  Future<List<Map<String, dynamic>>> fetchReview(int restaurantSeq) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/$restaurantSeq');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    final testjsonList = json.decode(response.body);
    List<dynamic> reviewList = testjsonList
        .map((json) => RestaurantReviewModel.fromJson(json))
        .toList();

    final jsonList = jsonDecode(utf8.decode(response.bodyBytes));
    // final jsonList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Map<String, dynamic>> result = jsonList
        .map<Map<String, dynamic>>((review) => review as Map<String, dynamic>)
        .toList();
    return result;
  }

  // 개별 리뷰 조회
  Future<RestaurantReviewModel> fetchReviewDetail(int reviewSeq) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/detail/$reviewSeq');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    RestaurantReviewModel review = RestaurantReviewModel.fromJson(jsonData);
    return review;
  }
}
