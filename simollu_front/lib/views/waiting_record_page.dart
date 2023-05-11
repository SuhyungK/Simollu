import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/waiting_record_card.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class WaitingRecordPage extends StatefulWidget {
  const WaitingRecordPage({Key? key}) : super(key: key);

  @override
  State<WaitingRecordPage> createState() => _WaitingRecordPageState();
}

class _WaitingRecordPageState extends State<WaitingRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
