import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simollu_front/root.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simollu_front/views/map_page.dart';
import 'package:simollu_front/views/restaurant_detail_page.dart';
import 'package:simollu_front/widgets/shadow_button.dart';

import '../viewmodels/UserViewmodel.dart';

class WaitingInfo {
  final String restaurant;
  final int waitingNumber;
  int waitingCount;
  int expectedWatingTime;

  WaitingInfo({
    required this.restaurant,
    required this.waitingNumber,
    required this.waitingCount,
    required this.expectedWatingTime,
  });
}

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

  UserViewModel userViewModel = UserViewModel();
  late String nickname = "";

  initNickname() async {
    nickname = (await userViewModel.getNickname()) as String;
    print("mypage screen"+nickname);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initNickname().then((_) {
      setState(() {
        nickname = nickname;
      });
    });
  }

  // WaitingInfo? waitingInfo;
  WaitingInfo? waitingInfo = WaitingInfo(
    expectedWatingTime: 160,
    restaurant: "바스버거ssssssssssssssssssssssssssssssssssssss",
    waitingCount: 15,
    waitingNumber: 2,
  );
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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            RootController.to.setRootPageTitles("지도");
            RootController.to.setIsMainPage(false);
            Navigator.push(
              context,
              GetPageRoute(
                curve: Curves.fastOutSlowIn,
                page: () => MapPage(),
              ),
            );
          },
          backgroundColor: Colors.amber,
          icon: Icon(Icons.location_on),
          label: Text(
            '경로 보기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
      body: SingleChildScrollView(
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
                          nickname+"님",
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
            Container(
              color: Colors.white,
              child: waitingInfo == null
                  ? null
                  : Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 3),
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "${waitingInfo?.restaurant}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "예상 대기 시간",
                                            style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${waitingInfo!.expectedWatingTime ~/ 60}시간 ${waitingInfo!.expectedWatingTime % 60}분",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "예상 대기 인원",
                                            style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${waitingInfo!.waitingCount}명",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("현재 대기 번호"),
                                    Text(
                                      "${waitingInfo?.waitingNumber}",
                                      style: TextStyle(
                                        color: Color(0xFFFFD200),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("순서 바꾸기");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFD200),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 3),
                                              blurRadius: 6,
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "순서 바꾸기",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("예약 취소");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCCCCCC),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 6),
                                              blurRadius: 3,
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "예약 취소",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              color: Colors.white,
              child: Column(
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
                            child: GestureDetector(
                              onTap: () {
                                RootController.to
                                    .setRootPageTitles(restaurants[index].name);
                                RootController.to.setIsMainPage(false);
                                Navigator.push(
                                  context,
                                  GetPageRoute(
                                    curve: Curves.fastOutSlowIn,
                                    page: () => RestaurantDetailpage(),
                                  ),
                                );
                              },
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
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
                                event: () {
                                  print(foodTypeIcons[index]["label"]);
                                },
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
                        (index) => GestureDetector(
                          onTap: () {
                            RootController.to
                                .setRootPageTitles(restaurants[index].name);
                            RootController.to.setIsMainPage(false);
                            Navigator.push(
                              context,
                              GetPageRoute(
                                curve: Curves.fastOutSlowIn,
                                page: () => RestaurantDetailpage(),
                              ),
                            );
                          },
                          child: Container(
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
                                  child:
                                      Image.asset(restaurants[index].imagePath),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.schedule,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              size: 20,
                                            ),
                                            Text(
                                              "${restaurants[index].watingMinutes}m",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
