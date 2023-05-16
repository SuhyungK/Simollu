import 'package:flutter/material.dart';
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/viewmodels/restaurant_view_model.dart';

class RestaurantReviewPage extends StatefulWidget {
  final List<RestaurantReviewModel> reviewList;

  const RestaurantReviewPage({
    Key? key,
    required this.reviewList,
  }) : super(key: key);

  @override
  State<RestaurantReviewPage> createState() => _RestaurantReviewPageState();
}

class _RestaurantReviewPageState extends State<RestaurantReviewPage> {
  RestaurantViewModel restaurantViewModel = RestaurantViewModel();

  Future<void> _handleTap(int reviewSeq) async {
    var result = await restaurantViewModel.fetchReviewDetail(reviewSeq);
    print(result.reviewContent);
  }

  @override
  Widget build(BuildContext context) {
    // return OutlinedButton(onPressed: (){ print(reviewList);}, child: Container( child: Text('버튼'),));
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.reviewList.length,
          itemBuilder: (context, index) {
            final review = widget.reviewList[index];
            return InkWell(
              onTap: () {
                _handleTap(review.reviewSeq);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '김싸피',
                            // review['userSeq'],
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3,),
                          review.reviewRating?
                            Text("기다릴만해요", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),)
                              :
                            Text('아쉬워요', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                          SizedBox(height: 3,),
                          Text(
                            review.reviewContent,
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
