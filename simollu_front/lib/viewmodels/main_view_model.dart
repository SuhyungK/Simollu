import 'package:get/get.dart';
import 'package:simollu_front/models/restaurantModel.dart';
import 'package:simollu_front/services/main_api.dart';

class MainViewModel extends GetxController {
  // 메인화면 식당 정보 리스트 상태 등록
  RxList<RestaurantModel> restaurantList = <RestaurantModel>[].obs;

  void getMainInfo() async {
    List<RestaurantModel> list = await MainApi().getRestaurantList();
    restaurantList(list);
  }
}
