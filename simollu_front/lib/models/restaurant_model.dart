class RestaurantModel {
  final int restaurantSeq;
  final String restaurantName;
  final int restaurantRating;
  final int restaurantWaitingTime;
  final String restaurantImage;

  RestaurantModel(
      {required this.restaurantSeq,
      required this.restaurantName,
      required this.restaurantRating,
      required this.restaurantWaitingTime,
      required this.restaurantImage});

  RestaurantModel.fromJSON(Map<String, dynamic> json)
      : restaurantSeq = json['restaurantSeq'] ?? '',
        restaurantName = json['restaurantName'] ?? '',
        restaurantRating = json['restaurantRating'] ?? 0,
        restaurantWaitingTime = json['restaurantWaitingTime'] ?? 0,
        restaurantImage = json['restaurantImage'] ?? '';
}
