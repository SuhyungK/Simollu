import 'package:http/http.dart' as http;
import 'package:simollu_front/utils/token.dart';

class RestaurantViewModel {
  late String token;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<void> fetchReview(int restaurantSeq) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/$restaurantSeq');
    final response = await http.get(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      
    );
  }
}