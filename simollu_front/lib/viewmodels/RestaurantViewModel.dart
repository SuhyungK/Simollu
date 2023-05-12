import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/utils/token.dart';

class RestaurantViewModel {
  late String token;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<List<Map<String, dynamic>>> fetchReview(int restaurantSeq) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/$restaurantSeq');
    final response = await http.get(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    List<Map<String, dynamic>> result = decodedResponse.map<Map<String, dynamic>>((review) => review as Map<String, dynamic>).toList();
    return result;
  }
}