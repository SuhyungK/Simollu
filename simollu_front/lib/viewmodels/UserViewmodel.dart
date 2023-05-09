import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/models/UserModel.dart';

class UserViewModel{
  Uri uri = Uri.parse('https://simollu.com/api/user/nickname');

  Future<String> getNickname() async {
    String nickname = "";

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhMGFhZTQ3Yi02ODM0LTQ3MTEtOWQ2ZC03MWQxNGMyYzk4MzAiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4MzY4MTI1OX0.GoN9Of44mvyOlK4ZAgNEeJrb09h-afojBakffVy0j2k"
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


}