import 'dart:convert';

class ReviewModel {
  int? restaurantSeq;
  int? reviewRating;
  String? reviewContent;

  ReviewModel(
      {this.restaurantSeq,
        this.reviewRating,
        this.reviewContent,
      });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'];
    reviewContent = json['reviewContent'];
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurantSeq'] = restaurantSeq;
    data['reviewRating'] = reviewRating;
    data['reviewContent'] = reviewContent;
    return jsonEncode(data);
  }
}