class RestaurantReviewModel {
  late int reviewSeq;
  late String userSeq;
  late int restaurantSeq;
  late bool reviewRating;
  late String reviewContent;
  late String reviewRegistDate;
  late String userImg;
  late String userNickname;

  RestaurantReviewModel({
    required this.reviewSeq,
    required this.userSeq,
    required this.restaurantSeq,
    required this.reviewRating,
    required this.reviewContent,
    required this.reviewRegistDate,
    required this.userImg,
    required this.userNickname,
  });

  RestaurantReviewModel.fromJson(Map<String, dynamic> json) {
    reviewSeq = json['reviewSeq'];
    userSeq = json['userSeq'];
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'];
    reviewContent = json['reviewContent'];
    reviewRegistDate = json['reviewRegistDate'];
    userImg = json['userImg'];
    userNickname = json['userNickname'];
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
