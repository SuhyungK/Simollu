import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class TestRestaurantDetailpage extends StatefulWidget {
  const TestRestaurantDetailpage({super.key});

  @override
  State<TestRestaurantDetailpage> createState() =>
      _TestRestaurantDetailpageState();
}

class _TestRestaurantDetailpageState extends State<TestRestaurantDetailpage> with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        title: '바스 버거',
        leading: Image.asset('assets/backBtn.png'),
        actions: [Image.asset('assets/bell.png')],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverAppBar(
            //   pinned: false,
            //   expandedHeight: 200,
            //   automaticallyImplyLeading: false,
            //   backgroundColor: Colors.white,
            //   // flexibleSpace: FlexibleSpaceBar(
            //   //   background: Image.asset(
            //   //     'assets/Rectangle 42.png',
            //   //     fit: BoxFit.cover,
            //   //   ),
            //   // ),
            //
            // ),
            SliverPersistentHeader(
              pinned: true,
              delegate:MyTabBarDelegate(
                tabBar: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Icon(Icons.favorite, color: Colors.black12,)),
                    Tab(icon: Icon(Icons.favorite)),
                    Tab(icon: Icon(Icons.favorite)),
                  ],
                ),
              )
            )
          ];
        },
          body: TabBarView(
            children: [
              Icon(Icons.favorite),
              Icon(Icons.favorite),
              Icon(Icons.favorite),
            ],
          ),
        )
      )
    );
  }
  Widget _menuDetail(List<List<String>> menuList) {
    return Column(
      children: menuList
          .map(
            (menu) => Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/${menu[0]}'),
            ),
            Column(
              children: [Text(menu[1]), Text(menu[2])],
            )
          ],
        ),
      )
          .toList(),
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