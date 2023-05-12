
class ReviewModel {
  int? reviewSeq;
  String? userSeq;
  int? restaurantSeq;
  late final int reviewRating;
  late final String reviewContent;
  String? reviewRegistDate;
  String? restaurantName;
  String? restaurantImg;

  ReviewModel(
      {
        this.reviewSeq,
        this.userSeq,
        this.restaurantSeq,
        required this.reviewRating,
        required this.reviewContent,
        this.reviewRegistDate,
        this.restaurantName,
        this.restaurantImg
      }
  );

  ReviewModel.fromJson(Map<String, dynamic> json) {
    reviewSeq = json['reviewSeq'];
    userSeq = json['userSeq'];
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'] ? 1 : 0;
    reviewContent = json['reviewContent'];
    reviewRegistDate = json['reviewRegistDate'];
    restaurantName = json['restaurantName'];
    restaurantImg = json['restaurantImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewSeq'] = reviewSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['reviewRating'] = reviewRating;
    data['reviewContent'] = reviewContent;
    data['reviewRegistDate'] = reviewRegistDate;
    data['restaurantName'] = restaurantName;
    data['restaurantImg'] = restaurantImg;
    return data;
  }
}