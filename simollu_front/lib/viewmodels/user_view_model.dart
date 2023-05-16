import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/forkModel.dart';
import 'package:simollu_front/utils/token.dart';

class UserViewModel extends GetxController {
  Uri baseUri = Uri.parse('https://simollu.com');
  String token = ""; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸
  RxString nickname = "".obs;
  RxString image = "".obs;

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  // [GET] User 프로필 이미지 조회
  Future<void> getProfileImage() async {
    await initialize();

    String newImage = "";

    Uri uri = baseUri.resolve("/api/user/user/profile-image");
    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      newImage = jsonDecode(responseBody)['userProfileUrl'];
      image(newImage);
    }
  }

  // [GET] User 닉네임 조회
  Future<void> getNickname() async {
    await initialize();

    String newNickname = "";

    Uri uri = baseUri.resolve("/api/user/user/nickname");
    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      newNickname = jsonDecode(responseBody)['userNicknameContent'];

      // nickname = jsonDecode(response.body)['userNicknameContent'];
      // print(nickname);
      nickname(newNickname);
    }
  }

  // [POST] User 닉네임 수정
  Future<String> postNickname(String nickname) async {
    String res = "";

    Uri uri = baseUri.resolve("/api/user/user/nickname");

    await initialize();

    final response = await http.post(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, body: json.encode({"userNicknameContent": nickname}), uri);

    print(response);
    print("post @@@@@" + response.body);

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
    Uri uri = baseUri.resolve("/api/user/user/fork");

    await initialize();

    int fork = 0;

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    print("---------@@@@@" + response.body);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      fork = jsonDecode(responseBody)['userFork'];
      print(fork);
    }

    return fork;
  }

  // [GET] User 포크 내역 리스트 조회
  Future<List<ForkModel>> getForkList() async {
    Uri uri = baseUri.resolve("/api/user/user/fork-list");

    await initialize();

    List<ForkModel> forkList = [];

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    print("---------@@@@@" + response.body);

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> res = jsonDecode(responseBody);

      for (dynamic r in res) {
        forkList.add(ForkModel.fromJson(r));
        print(r);
      }
      print(forkList);
    }

    return forkList;
  }
}
