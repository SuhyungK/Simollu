import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/preferenceModel.dart';
import 'package:simollu_front/utils/token.dart';

class PreferenceViewModel {
  late String token;

  Future<void> initialize() async {
    token = await getToken();
  }

  PreferenceViewModel() {
    initialize();
  }
  
  Future<PreferenceModel> postPreference(String json) async {
    late PreferenceModel result;
    await initialize();
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
      result = PreferenceModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to post preferences...');
    }
    return result;
  }

  Future<List<String>>getPreference() async {
    await initialize();
    late List<String> result;
    var url = Uri.https('simollu.com', '/api/user/user/preference');

    final response = await http.get(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization" : token
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      result = jsonDecode(utf8.decode(response.bodyBytes))['userPrefernceList']?.cast<String>();
      // result = PreferenceModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to get preferences...');
    }
    return result;

  }
}