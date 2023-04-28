import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class WaitingRecord extends StatefulWidget {
  const WaitingRecord({Key? key}) : super(key: key);

  @override
  State<WaitingRecord> createState() => _WaitingRecordState();
}

class _WaitingRecordState extends State<WaitingRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: '웨이팅 기록',
          leading: Image.asset('assets/backBtn.png'),
          actions: [Image.asset('assets/bell.png')],
        ),
        body: CustomTabBar(length: 2, tabs: [
          '이용 완료',
          '취소 내역'
        ], tabViews: [
          // 위젯 리스트
          usageHistory(),
          cancelWaiting(),
        ]));
  }

  Widget usageHistory() {
    // 사용 내역 tabView 내용 위젯
    return Column(
      children: [
        WaitingRecordcard(),
        WaitingRecordcard(),
        WaitingRecordcard(),
      ],
    );
  }

  Widget cancelWaiting() {
    // 이용 취소 tabView 내용 위젯
    return Column(
      children: [
        WaitingRecordcard(
          isCanclled: true,
        ),
        WaitingRecordcard(
          isCanclled: true,
        ),
        WaitingRecordcard(
          isCanclled: true,
        ),
        WaitingRecordcard(
          isCanclled: true,
        ),
      ],
    );
  }
}
