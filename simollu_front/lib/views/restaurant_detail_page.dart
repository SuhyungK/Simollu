import 'package:flutter/material.dart';
import 'package:simollu_front/viewmodels/RestaurantViewModel.dart';
import 'package:simollu_front/views/restaurant_review_page.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class RestaurantDetailpage extends StatefulWidget {
  const RestaurantDetailpage({super.key});

  @override
  State<RestaurantDetailpage> createState() =>
      _RestaurantDetailpageState();
}

class _RestaurantDetailpageState extends State<RestaurantDetailpage> with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  final List<List<String>> _menuList = [
    ['burger.jpg', '햄버거', '15,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
    ['potato.jpg', '감자튀김', '13,000'],
  ];
  late List<Map<String, dynamic>> reviewList = [];
  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchReviewData();
  }

  Future<void> fetchReviewData() async {
    RestaurantViewModel restaurantViewModel = RestaurantViewModel();
    List<Map<String, dynamic>> result = await restaurantViewModel.fetchReview(2);
    // result.sort((a, b) => (b['reviewSeq'].compareTo(a['reviewSeq'])));
    reviewList.sort((a, b) => (b['reviewRating'] ? 1 : 0) - (a['reviewRating'] ? 1 : 0));
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
            _menuDetail(_menuList),
            _restaurantInfo(),
            RestaurantReviewPage(reviewList: reviewList)
            // Column(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //           border: Border(
            //               bottom: BorderSide(
            //                   color: Colors.black12
            //               )
            //           )
            //       ),
            //       child: ListTile(
            //           leading: Icon(Icons.circle, size: 50),
            //           title: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('작성자', style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 22
            //               )),
            //               Text('직원분들 유쾌하고 활기 넘치고 음식도 맛있어요 교대점이랑은 극과극')
            //             ],
            //           )
            //       ),
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //           border: Border(
            //               bottom: BorderSide(
            //                   color: Colors.black12
            //               )
            //           )
            //       ),
            //       child: ListTile(
            //           leading: Icon(Icons.circle, size: 50),
            //           title: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('작성자', style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 22
            //               )),
            //               Text('직원분들 유쾌하고 활기 넘치고 음식도 맛있어요 교대점이랑은 극과극')
            //             ],
            //           )
            //       ),
            //     ),
            //   ],
            // )
          ],
          hasSliverAppBar: true,
          flexibleImage: 'assets/Rectangle 42.png',
          bottomWidget: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.16,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                              '바스버거',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '양식',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          '서울특별시 강남구 역삼동 777',
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(height: 10,),
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
                          _isLike ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _isLike = false;
                                });
                              },
                              icon: Icon(Icons.favorite, color: Colors.pink,)
                          ) : IconButton(
                              onPressed: () {
                                setState(() {
                                  _isLike = true;
                                });
                              },
                              icon: Icon(Icons.favorite_border, color: Colors.pink,)
                          )
                          ,
                          ButtonTheme(
                            child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: BorderSide(
                                      color: Colors.black12,
                                    ),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.3,
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
          )
      ),
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
  Widget _menuDetail(List<List<String>> menuList) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: menuList
            .map(
              (menu) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Image.asset('assets/${menu[0]}', width: 100,),
                Column(
                  children: [Text(menu[1]), Text(menu[2])],
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
  Widget build(BuildContext context, double shrinkOffest, bool overlapsContent) {
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}