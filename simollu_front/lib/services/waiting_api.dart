import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/utils/token.dart';

class WaitingApi {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<void> postWaiting(int restaurantSeq, int waitingPersonCnt, String restaurantName) async {
    // 식당 일련번호, 웨이팅 인원, 식당 이름
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/waiting/user');
    print("api 통신 시작 전 데이터 확인 :");
    print(restaurantSeq);
    print(waitingPersonCnt);
    print(restaurantName);
    final response = await http.post(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        body: json.encode({
          "restaurantSeq" : restaurantSeq,
          "waitingPersonCnt" : waitingPersonCnt,
          "restaurantName" : restaurantName
        }),
        uri);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {

      int res = json.decode(utf8.decode(response.bodyBytes));

      print("웨이팅 등록 api 통신결과 :");
      print(res);
      // print("result :" + jsonDecode(response.body)["result"]);
    }

  }
}