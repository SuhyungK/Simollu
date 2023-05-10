import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:simollu_front/models/place.dart';

class KakaoMapAPI {
  final String baseUrl = 'https://dapi.kakao.com/v2/local/search/keyword.JSON';

  Future<List<Place>> getPlaces(LatLng dest, String keyword) async {
    String apiUrl = baseUrl +
        "?query=${keyword}&x=${dest.longitude}&y=${dest.latitude}&radius=500";
    print("asdfdsf");
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': dotenv.env['kakaoMapApiKey']!,
    });
    print("start");
    print(response.body + "asdasf");
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      List<Place> ret = [];
      List<dynamic> placeList = json.decode(response.body)['documents'];
      for (dynamic places in placeList) {
        ret.add(Place.fromJSON(places));
      }
      return ret;
    } else {
      // 요청 실패 처리
      return [];
    }
  }

  /*
  */
}
