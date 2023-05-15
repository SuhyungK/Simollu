import 'package:get/get.dart';
import 'package:simollu_front/models/main_info_model.dart';
import 'package:simollu_front/models/restaurant_model.dart';
import 'package:simollu_front/services/main_api.dart';

enum SortBy {
  NearBy,
  HighRaiting,
  LessWaiting,
}

enum Category {
  Korean,
  Western,
  Chinese,
  Japanese,
  FastFood,
  Cafe,
  Bakery,
}

class MainViewModel extends GetxController {
  Rx<SortBy> sortBy = SortBy.NearBy.obs;
  Rx<Category> category = Category.Korean.obs;
  Rx<MainInfoModel> mainInfo = MainInfoModel(
    restaurantNearByList: [],
    restaurantHighRatingList: [],
    restaurantLessWaitingList: [],
    koreanFoodTopList: [],
    westernFoodTopList: [],
    chineseTopList: [],
    japaneseTopList: [],
    fastFoodTopList: [],
    cafeTopList: [],
    bakeryTopList: [],
  ).obs;
  // 메인화면 식당 정보 리스트 상태 등록

  void changeSortBy(SortBy newSortBy) {
    sortBy.value = newSortBy;
  }

  void changeCategroy(Category newCategory) {
    category.value = newCategory;
  }

  void getMainInfo() async {
    mainInfo.value = await MainApi().getRestaurantList();
  }
}
