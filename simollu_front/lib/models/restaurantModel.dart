
class RestaurantModel {
  late String restaurantName;
  late int restaurantRating;
  late int restaurantWaitingTime;
  late String restaurantImage;

  RestaurantModel({
    required this.restaurantName,
    required this.restaurantRating,
    required this.restaurantWaitingTime,
    required this.restaurantImage
  });

  RestaurantModel.fromJSON(Map<String, dynamic> json)
      : restaurantName = json['restaurantName'] ?? '',
        restaurantRating = json['restaurantRating'] ?? 0,
        restaurantWaitingTime = json['restaurantWaitingTime'] ?? 0,
        restaurantImage = json['restaurantImage'] ?? '';
}
