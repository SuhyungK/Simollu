import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/PreferenceModel.dart';
import 'package:simollu_front/models/SearchModel.dart';
import 'package:simollu_front/utils/token.dart';

class PreferenceViewModel {
  late String token;

  Future<void> initialize() async {
    token = await getToken();
  }
  
  Future<PreferenceModel> postPreference(String json) async {
    late PreferenceModel result;
    initialize();
    var url = Uri.https('simollu.com', '/api/user/preference');
    // Uri uri = Uri.parse('https://simollu.com/api/user/preference');
    final response = await http.post(
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization" : token
      },
        body: json,
      url);

    if (response.statusCode == 200) {
      result = PreferenceModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post preferences...');
    }

    return result;
  }

  // Future<List<PreferenceModel>> getPreference() async {
  //   Uri uri = U
  // }
}