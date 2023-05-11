import 'dart:convert';

class ReviewModel {
  int? restaurantSeq;
  int? reviewRating;
  String? reviewContent;
  int? reviewSeq;

  ReviewModel(
      {this.restaurantSeq,
        this.reviewRating,
        this.reviewContent,
        this.reviewSeq,
      });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'];
    reviewContent = json['reviewContent'];
    reviewSeq = json['reviewSeq'];
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurantSeq'] = restaurantSeq;
    data['reviewRating'] = reviewRating;
    data['reviewContent'] = reviewContent;
    data['reviewSeq'] = reviewSeq;
    return jsonEncode(data);
  }
}