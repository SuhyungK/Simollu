import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/restaurant_list_item.dart';

class InterestingRestaurantsPage extends StatelessWidget {
  InterestingRestaurantsPage({super.key});

  final List<Restaurant> restaurants = [
    Restaurant(
      id: "1",
      iamgePath: "assets/basBurgerImg.png",
      name: "바스 버거",
      likePercentages: 80.0,
      kind: "양식",
      location: "역삼동",
      isLike: false,
    ),
    Restaurant(
      id: "2",
      iamgePath: "assets/basBurgerImg.png",
      name: "바스 버거",
      likePercentages: 80.0,
      kind: "양식",
      location: "역삼동",
      isLike: true,
    ),
    Restaurant(
      id: "3",
      iamgePath: "assets/basBurgerImg.png",
      name: "바스 버거",
      likePercentages: 80.0,
      kind: "양식",
      location: "역삼동",
      isLike: false,
    ),
    Restaurant(
      id: "3",
      iamgePath: "assets/basBurgerImg.png",
      name: "바스 버거",
      likePercentages: 80.0,
      kind: "양식",
      location: "역삼동",
      isLike: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              restaurants.length,
              (index) => RestaurantListItem(
                restaurant: restaurants[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
