import 'dart:convert';

import 'package:get/get.dart';
import 'package:simollu_front/services/waiting_api.dart';

import '../utils/token.dart';
import 'package:simollu_front/models/waiting_record_model.dart';
import 'package:http/http.dart' as http;

class WaitingViewModel extends GetxController {
  RxInt waitingSeq = 0.obs;
  RxInt waitingNo = 0.obs;
  RxInt waitingTime = 0.obs;
  RxString restaurantName = "".obs;

  static Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<bool> postWaiting(
      int restaurantSeq, int waitingPersonCnt, String restaurantName) async {
    WaitingRecordModel? res = await WaitingApi()
        .postWaiting(restaurantSeq, waitingPersonCnt, restaurantName);
    if (res == null) {
      return false;
    }
    waitingSeq.value = res.waitingSeq;
    waitingNo.value = res.waitingNo;
    waitingTime.value = res.waitingTime;
    this.restaurantName.value = res.restaurantName;
    return true;
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
