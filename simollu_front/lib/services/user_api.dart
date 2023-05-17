import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/utils/token.dart';

class UserAPI {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸
  final Uri baseUrl = Uri.parse("https://simollu.com");

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<int> getFork() async {
    await initialize();
    Uri url = baseUrl.resolve("/api/user/user/fork");

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, url);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));

      return res['userFork'];
    }

    return -1;
  }
}
