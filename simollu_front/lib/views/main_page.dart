import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simollu_front/widgets/shadow_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, Object>> sortingOptions = [
    {
      "label": "가까운 순",
      "state": false,
    },
    {
      "label": "별점높은 순",
      "state": false,
    },
    {
      "label": "대기시간 적은 순",
      "state": false,
    }
  ];

  List<Map<String, Object>> restaurants = [
    {
      "imagePath": "assets/basBurgerImg.png",
      "name": "바스버거",
      "likePercentages": 80.0,
      "waitingMinutes": 15,
    },
    {
      "imagePath": "assets/basBurgerImg.png",
      "name": "바스버거",
      "likePercentages": 80.0,
      "waitingMinutes": 15,
    },
    {
      "imagePath": "assets/basBurgerImg.png",
      "name": "바스버거",
      "likePercentages": 80.0,
      "waitingMinutes": 15,
    },
    {
      "imagePath": "assets/basBurgerImg.png",
      "name": "바스버거",
      "likePercentages": 80.0,
      "waitingMinutes": 15,
    },
    {
      "imagePath": "assets/basBurgerImg.png",
      "name": "바스버거",
      "likePercentages": 80.0,
      "waitingMinutes": 15,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            color: Color(0xFFFFD200),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "KOEH님",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "오늘은 어디로 가볼까요?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 28,
                bottom: -10,
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 64,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFD200),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 36, 0, 0),
                  child: Text(
                    "여기서 먹어볼까요?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // 식당 정렬 순서 토글 행
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      3,
                      (index) => ShadowButton(
                        event: () {
                          setState(() {
                            sortingOptions[index]["state"] =
                                !(sortingOptions[index]["state"] as bool);
                          });
                        },
                        color: sortingOptions[index]["state"] as bool
                            ? 0xFFFFD200
                            : 0xFFAAAAAA,
                        child: Text(
                          sortingOptions[index]["label"] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // 음식 리스트
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        restaurants.length,
                        (index) => Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset(
                                  restaurants[index]["imagePath"] as String),
                              Text(restaurants[index]["name"] as String)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
