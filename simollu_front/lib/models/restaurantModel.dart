
class RestaurantReviewModel {
  int? reviewSeq;
  String? userSeq;
  int? restaurantSeq;
  bool? reviewRating;
  String? reviewContent;
  String? reviewRegistDate;

  RestaurantReviewModel(
      {reviewSeq,
        userSeq,
        restaurantSeq,
        reviewRating,
        reviewContent,
        reviewRegistDate});

  RestaurantReviewModel.fromJson(Map<String, dynamic> json) {
    reviewSeq = json['reviewSeq'];
    userSeq = json['userSeq'];
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'];
    reviewContent = json['reviewContent'];
    reviewRegistDate = json['reviewRegistDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewSeq'] = reviewSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['reviewRating'] = reviewRating;
    data['reviewContent'] = reviewContent;
    data['reviewRegistDate'] = reviewRegistDate;
    return data;
  }
}