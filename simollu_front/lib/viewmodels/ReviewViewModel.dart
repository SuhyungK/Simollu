import 'dart:convert';

import 'package:simollu_front/models/ReviewModel.dart';
import 'package:simollu_front/utils/token.dart';
import 'package:http/http.dart' as http;

class ReviewMViewModel {
  late int restaurantSeq;
  late int reviewRating;
  late String reviewContent;


  Future<void> postReview(String json) async {
    String token = await getToken();
    var url = Uri.https('simollu.com', '/api/restaurant/review');
    final response = await http.post(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization" : token
      },
      body: json,
    );

  }

}