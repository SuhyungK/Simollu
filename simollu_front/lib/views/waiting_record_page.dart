import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';

class WaitingRecord extends StatefulWidget {
  const WaitingRecord({Key? key}) : super(key: key);

  @override
  State<WaitingRecord> createState() => _WaitingRecordState();
}

class _WaitingRecordState extends State<WaitingRecord> with TickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomAppBar(
          title: '웨이팅 기록',
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
        ),
        body: Column(
          children: [
            _buildTabBar(),
            Expanded(child: _buildTabBarView()),
          ],
        ),
      ),
    );
  }


  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.5
          )
        )
      ),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            child: Text(
              '사용 내역',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17
              ),
            ),
          ),
          Tab(
            child: Text(
              '이용 취소',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17
              ),
            ),
          ),
        ],
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.all(5.0),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal
        ),

      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        Column(
          children: [
            WaitingRecordcard(),
            WaitingRecordcard(),
          ],
        ),
        Column(
          children: [
            WaitingRecordcard(isCanclled: true,),
          ],
        ),
      ],
    );
  }
}
