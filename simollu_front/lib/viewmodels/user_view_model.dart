import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/models/forkModel.dart';
import 'package:simollu_front/utils/token.dart';

class UserViewModel{
  Uri uri = Uri.parse('https://simollu.com/api/user/user/nickname');
  String token = ""; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  // [GET] User 닉네임 조회
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

  // [POST] User 닉네임 수정
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

  // [GET] User 포크 수 조회
  Future<int> getForkNumber() async {
    Uri uri2 = Uri.parse("https://simollu.com/api/user/user/fork");

    await initialize();

    int fork = 0;

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        uri2);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {

      final responseBody = utf8.decode(response.bodyBytes);
      fork = jsonDecode(responseBody)['userFork'];
      print(fork);
    }

    return fork;
  }

  // [GET] User 포크 내역 리스트 조회
  Future<List<ForkModel>> getForkList() async {
    Uri uri2 = Uri.parse("https://simollu.com/api/user/user/fork-list");

    await initialize();

    List<ForkModel> forkList = [];

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        uri2);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {

      final responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> res = jsonDecode(responseBody);
      
      for(dynamic r in res) {
        forkList.add(ForkModel.fromJson(r));
        print(r);
      }
      print(forkList);
    }

    return forkList;
  }
}