import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class TestRestaurantDetailpage extends StatefulWidget {
  const TestRestaurantDetailpage({super.key});

  @override
  State<TestRestaurantDetailpage> createState() =>
      _TestRestaurantDetailpageState();
}

class _TestRestaurantDetailpageState extends State<TestRestaurantDetailpage> {
  final List<List<String>> _menuList = [
    ['burgur.jpg', '햄버거', '15,000'],
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
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(
        title: '바스 버거',
        leading: Image.asset('assets/backBtn.png'),
        actions: [Image.asset('assets/bell.png')],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text('asdf'),
            // pinned: true,
            automaticallyImplyLeading: false,
            primary: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg',
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.parallax,
            ),
            expandedHeight: 200,
            // backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              color: Colors.white,
              child: CustomTabBar(
                length: 3,
                tabs: ['메뉴', '매장 정보', '리뷰'],
                tabViews: [
                  _menuDetail(_menuList),
                  _restaurantInfo(),
                  Container()
                ],
              ),
            )
          ),
        ],
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