class RestaurantModel {
  final int restaurantSeq;
  final String restaurantName;
  final int restaurantRating;
  final int restaurantWaitingTime;
  final String restaurantImage;
  final String restaurantAddress;
  final double distance;

  RestaurantModel({
    required this.restaurantSeq,
    required this.restaurantName,
    required this.restaurantRating,
    required this.restaurantWaitingTime,
    required this.restaurantImage,
    required this.restaurantAddress,
    required this.distance,
  });

  RestaurantModel.fromJSON(Map<String, dynamic> json)
      : restaurantSeq = json['restaurantSeq'] ?? '',
        restaurantName = json['restaurantName'] ?? '',
        restaurantRating = json['restaurantRating'] ?? 0,
        restaurantWaitingTime = json['restaurantWaitingTime'] ?? 0,
        restaurantImage = json['restaurantImage'] ?? '',
        restaurantAddress = json['restaurantAddress'] ?? '',
        distance = json['distance'] ?? 0;
}
