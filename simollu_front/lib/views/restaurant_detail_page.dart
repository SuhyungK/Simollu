import 'package:flutter/material.dart';
import 'package:simollu_front/models/menuInfoModel.dart';
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/services/restaurant_detail_api.dart';
import 'package:simollu_front/viewmodels/restaurant_view_model.dart';
import 'package:simollu_front/views/restaurant_review_page.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

import '../models/restaurantDetailModel.dart';

class RestaurantDetailpage extends StatefulWidget {
  final int restaurantSeq;

  const RestaurantDetailpage({
    Key? key,
    required this.restaurantSeq,
  });

  @override
  State<RestaurantDetailpage> createState() => _RestaurantDetailpageState();
}

class _RestaurantDetailpageState extends State<RestaurantDetailpage>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  late RestaurantDetailModel result;

  getRestaurantDetailInfo() async {
    RestaurantDetailApi restaurantDetailApi = RestaurantDetailApi();

    result = await restaurantDetailApi.getRestaurantDetailInfo(widget.restaurantSeq);
    print('가게 상세 정보 조회 api 연결 후 결과 :');
    print(result.menuInfoList);
    print(result.restaurantInfo);
    print(result.waitingTimeList);
  }

  late List<RestaurantReviewModel> reviewList = [];
  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchReviewData();
    getRestaurantDetailInfo();
  }

  Future<void> fetchReviewData() async {
    RestaurantViewModel restaurantViewModel = RestaurantViewModel();
    List<RestaurantReviewModel> result =
        await restaurantViewModel.fetchReview(widget.restaurantSeq);
    // result.sort((a, b) => (b['reviewSeq'].compareTo(a['reviewSeq'])));

    print(result);
    setState(() {
      reviewList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
          length: 3,
          tabs: ['메뉴', '매장 정보', '리뷰'],
          tabViews: [
            _menuDetail(result.menuInfoList),
            _restaurantInfo(),
            RestaurantReviewPage(reviewList: reviewList)
          ],
          hasSliverAppBar: true,
          flexibleImage:result.restaurantInfo.restaurantImg,
          bottomWidget: Container(
            color: Colors.white,
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              result.restaurantInfo.restaurantName,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              result.restaurantInfo.restaurantCategory,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          result.restaurantInfo.restaurantAddress,
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Text(
                              '기다릴만해요 87%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _isLike
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLike = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLike = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.pink,
                                  )),
                          ButtonTheme(
                            child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: BorderSide(
                                      color: Colors.black12,
                                    ),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width * 0.3,
                                        40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                child: Text(
                                  '예상대기시간',
                                  maxLines: 1,
                                )),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }

  // DefaultTabController buildDefaultTabController() {
  // return
  // return DefaultTabController(
  //   length: 3,
  //   child: NestedScrollView(
  //     headerSliverBuilder:
  //         (BuildContext context, bool innerBoxIsScrolled) {
  //     return <Widget>[
  //       // SliverAppBar(
  //       //   pinned: false,
  //       //   expandedHeight: 200,
  //       //   automaticallyImplyLeading: false,
  //       //   backgroundColor: Colors.white,
  //       //   // flexibleSpace: FlexibleSpaceBar(
  //       //   //   background: Image.asset(
  //       //   //     'assets/Rectangle 42.png',
  //       //   //     fit: BoxFit.cover,
  //       //   //   ),
  //       //   // ),
  //       //
  //       // ),
  //       SliverPersistentHeader(
  //         pinned: true,
  //         delegate:MyTabBarDelegate(
  //           tabBar: TabBar(
  //             controller: _tabController,
  //             tabs: [
  //               Tab(icon: Icon(Icons.favorite, color: Colors.black12,)),
  //               Tab(icon: Icon(Icons.favorite)),
  //               Tab(icon: Icon(Icons.favorite)),
  //             ],
  //           ),
  //         )
  //       )
  //     ];
  //   },
  //     body: TabBarView(
  //       children: [
  //         Icon(Icons.favorite),
  //         Icon(Icons.favorite),
  //         Icon(Icons.favorite),
  //       ],
  //     ),
  //   )
  // );
  // }
  Widget _menuDetail(List<MenuInfoModel> menuList) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: menuList
            .map(
              (menu) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Image.network(
                      menu.menuImage ??
                          'https://example.com/placeholder.jpg', // imageUrl 값이 없을 경우 대체 이미지 URL 사용
                      width: 80,
                      // height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // 이미지 로딩 실패 시 대체 이미지 보여주기
                        return Image.network(
                          'https://cdn.pixabay.com/photo/2023/04/28/07/07/cat-7956026_960_720.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Column(
                      children: [Text(menu.menuName), Text(menu.menuPrice)],
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _restaurantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '영업 정보',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(flex: 3, child: Text('운영 ')),
            Expanded(flex: 7, child: Text('월 ~ 금 10:00')),
          ],
        ),
        Row(
          children: [
            Expanded(flex: 3, child: Text('전화 번호 ')),
            Expanded(flex: 7, child: Text('월 ~ 금 10:00')),
          ],
        ),
      ],
    );
  }
}

class MyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  MyTabBarDelegate({required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffest, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
