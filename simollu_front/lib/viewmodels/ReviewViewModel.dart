import 'package:simollu_front/utils/token.dart';
import 'package:http/http.dart' as http;

class ReviewMViewModel {
  late int restaurantSeq;
  late int reviewRating;
  late String reviewContent;
  int? reviewSeq;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<String> postReview(String json) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review');
    final response = await http.post(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      body: json,
    );
    return response.body;
  }

    Future<void> putReview(String reviewSeq, String json) async {
      String token = await getToken();
      var url = createUrl('/restaurant/review/detail/$reviewSeq');
      await http.put(url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        body: json
      );
    }
  }

