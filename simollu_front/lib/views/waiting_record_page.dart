import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';

import '../widgets/custom_appBar.dart';

class WaitingRecord extends StatelessWidget {
  const WaitingRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar(
            title: "웨이팅 기록",
            leading: Image.asset('assets/backBtn.png'),
            actions: [Image.asset('assets/bell.png')],
            shape: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 0.5
              )
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500, // 선택되지 않은 탭의 글꼴 두께 (medium)
              ),
              tabs: [
                Tab(
                  child: Text(
                    '사용 완료',
                  ),
                ),
                Tab(
                  child: Text(
                    '이용 취소'
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            children: [
              Column(
                children: [
                  WaitingRecordcard(),
                ],
              ),
              Column(
                children: [
                  WaitingRecordcard(isCanclled: true,),
                ],
              ),
            ],
          )
        )
    );
  }
}

