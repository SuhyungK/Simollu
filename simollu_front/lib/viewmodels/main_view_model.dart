import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simollu_front/services/kakao_map_api.dart';

class MainViewModel extends GetxController {
  RxString dong = "".obs;

  void getDong(LatLng location) async {
    String newDong = await KakaoMapAPI().getCurrentLocationAddress(location);

    dong(newDong);
  }
}
