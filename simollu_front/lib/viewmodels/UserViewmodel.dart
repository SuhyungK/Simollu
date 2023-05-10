import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/utils/token.dart';

class UserViewModel{
  Uri uri = Uri.parse('https://simollu.com/api/user/nickname');
  String token = ""; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<String> getNickname() async {

    await initialize();

    String nickname = "";

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        uri);
    print(response);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {

      final responseBody = utf8.decode(response.bodyBytes);
      nickname = jsonDecode(responseBody)['userNicknameContent'];
      print(nickname);

      // nickname = jsonDecode(response.body)['userNicknameContent'];
      // print(nickname);
    }

    return nickname;
  }

  Future<String> postNickname(String nickname) async {
    String res = "";

    await initialize();

    final response = await http.post(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": token
        },
        body: json.encode({
          "userNicknameContent" : nickname
        }),
        uri);


    print(response);
    print("post @@@@@"+response.body);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(responseBody);
      nickname = jsonResponse['userNicknameContent'];
      print(nickname);
      res = nickname;
    }

    return res;
  }
}