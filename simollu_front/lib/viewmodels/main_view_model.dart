import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simollu_front/models/restaurantModel.dart';
import 'package:simollu_front/services/kakao_map_api.dart';
import 'package:simollu_front/services/main_api.dart';

class MainViewModel extends GetxController {
  RxString dong = "".obs;

  void getDong(LatLng location) async {
    String newDong = await KakaoMapAPI().getCurrentLocationAddress(location);

    dong(newDong);
  }

  // 메인화면 식당 정보 리스트 상태 등록
  RxList<RestaurantModel> restaurantList = <RestaurantModel>[].obs;

  void getMainInfo() async {
    List<RestaurantModel> list = await MainApi().getRestaurantList();
    restaurantList(list);
  }
}
