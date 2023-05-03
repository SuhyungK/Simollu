import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simollu_front/widgets/shadow_button.dart';

class Restaurant {
  final String name;
  final String imagePath;
  final double likes;
  final int watingMinutes;
  final String location;
  final double distance;

  Restaurant({
    required this.name,
    required this.imagePath,
    required this.likes,
    required this.watingMinutes,
    required this.location,
    required this.distance,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, String>> foodTypeIcons = [
    {
      "imagePath": "assets/icons/korean.png",
      "label": "한식",
    },
    {
      "imagePath": "assets/icons/western.png",
      "label": "양식",
    },
    {
      "imagePath": "assets/icons/chinese.png",
      "label": "중식",
    },
    {
      "imagePath": "assets/icons/japanese.png",
      "label": "일식",
    },
    {
      "imagePath": "assets/icons/fastfood.png",
      "label": "패스트푸드",
    },
    {
      "imagePath": "assets/icons/cafe.png",
      "label": "카페",
    },
    {
      "imagePath": "assets/icons/bakery.png",
      "label": "베이커리",
    },
  ];
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

  List<Restaurant> restaurants = [
    Restaurant(
      name: "바스버거dddddddddddddddddddddddddddddddddddddddddddddddddd",
      imagePath: "assets/basBurgerImg.png",
      likes: 80.0,
      watingMinutes: 15,
      location: "역삼동",
      distance: 0.5,
    ),
    Restaurant(
      name: "바스버거",
      imagePath: "assets/basBurgerImg.png",
      likes: 80.0,
      watingMinutes: 15,
      location: "역삼동",
      distance: 0.5,
    ),
    Restaurant(
      name: "바스버거",
      imagePath: "assets/basBurgerImg.png",
      likes: 80.0,
      watingMinutes: 15,
      location: "역삼동",
      distance: 0.5,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            height: 50,
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
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                  restaurants[index].imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                restaurants[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Color(0xFFFFD200),
                                  ),
                                  Text(
                                    "${restaurants[index].likes}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                  ),
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.grey.withOpacity(0.8),
                                    size: 20,
                                  ),
                                  Text(
                                    "${restaurants[index].watingMinutes}m",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: RichText(
                  text: TextSpan(
                    text: "요즘 ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "HOT",
                        style: TextStyle(
                          color: Color(0xFFFF6000),
                        ),
                      ),
                      TextSpan(
                        text: "한 맛집!",
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      foodTypeIcons.length,
                      (index) => Column(
                        children: [
                          ShadowButton(
                            color: 0xFFFFD200,
                            event: () {},
                            child: SizedBox(
                              width: 64,
                              height: 64,
                              child: Image.asset(
                                foodTypeIcons[index]["imagePath"] as String,
                              ),
                            ),
                          ),
                          Text(
                            foodTypeIcons[index]["label"] as String,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ...List.generate(
                    restaurants.length,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            child: Image.asset(restaurants[index].imagePath),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurants[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer_outlined,
                                        color: Color(0xFFFFD200),
                                      ),
                                      Text(
                                        "${restaurants[index].likes}%",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.schedule,
                                        color: Colors.grey.withOpacity(0.8),
                                        size: 20,
                                      ),
                                      Text(
                                        "${restaurants[index].watingMinutes}m",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${restaurants[index].location} ${restaurants[index].distance}km",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
