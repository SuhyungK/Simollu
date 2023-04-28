import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: '웨이팅 기록',
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
        ),
        body: CustomTabBar(
          length: 2,
          tabs: ['사용 내역', '이용 취소'],
          tabViews: [ // 위젯 리스트
            usageHistory(),
            cancelWaiting()
          ]
        )
      );
    }

  Widget usageHistory() { // 사용 내역 tabView 내용 위젯
    return Column(
      children: [
        WaitingRecordcard(),
        WaitingRecordcard(),
        WaitingRecordcard(),
      ],
    );
  }

  Widget cancelWaiting() { // 이용 취소 tabView 내용 위젯
    return Column(
      children: [
        WaitingRecordcard(isCanclled: true,),
        WaitingRecordcard(isCanclled: true,),
        WaitingRecordcard(isCanclled: true,),
        WaitingRecordcard(isCanclled: true,),
      ],
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
        SingleChildScrollView(
          child: Column(
            children: [
              WaitingRecordcard(),
              WaitingRecordcard(),
              WaitingRecordcard(),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              WaitingRecordcard(isCanclled: true,),
              WaitingRecordcard(isCanclled: true,),
              WaitingRecordcard(isCanclled: true,),
              WaitingRecordcard(isCanclled: true,),
            ],
          ),
        ),
      ],
    );
  }
}
