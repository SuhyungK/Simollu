import 'package:flutter/material.dart';

class RestaurantReviewPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviewList;

  const RestaurantReviewPage({
    Key? key,
    required this.reviewList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return OutlinedButton(onPressed: (){ print(reviewList);}, child: Container( child: Text('버튼'),));
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviewList.length,
          itemBuilder: (context, index) {
            final review = reviewList[index];
            return Padding(
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
                        review['reviewRating'] ?
                          Text("기다릴만해요", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                            :
                          Text('아쉬워요', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text(
                          review['reviewContent'],
                          softWrap: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
