import 'dart:convert';

import 'package:get/get.dart';
import 'package:simollu_front/services/waiting_api.dart';

import '../utils/token.dart';
import 'package:simollu_front/models/waitingRecordModel.dart';
import 'package:http/http.dart' as http;

class WaitingViewModel extends GetxController {
  static Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<bool> postWaiting(
      int restaurantSeq, int waitingPersonCnt, String restaurantName) async {
    await WaitingApi()
        .postWaiting(restaurantSeq, waitingPersonCnt, restaurantName);
    return false;
  }

  // 웨이팅 내역 조회(완료)
  static Future<List<WaitingRecordModel>> fetchWaitingRecord(
      int waitingStatusContent) async {
    List<WaitingRecordModel> result = [];
    String token = await getToken();
    var url = createUrl('/waiting/user/status/$waitingStatusContent');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    if (response.statusCode == 200) {
      final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
      result = (decodedList as List)
          .map((item) => WaitingRecordModel.fromJson(item))
          .toList();
    } else {
      throw Error();
    }
    print(result);
    return result;
  }
}
