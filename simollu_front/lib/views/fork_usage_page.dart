import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';

class ForkUsagePage extends StatefulWidget {
  const ForkUsagePage({Key? key}) : super(key: key);

  @override
  State<ForkUsagePage> createState() => _ForkUsagePageState();
}

class _ForkUsagePageState extends State<ForkUsagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 없앨 예정
      appBar: CustomAppBar(
        title: '포크 사용 내역',
        leading: Icon(Icons.arrow_back),
        actions: [
          Icon(Icons.no_accounts)
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Text('보유 포크'),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  Text('2000개'),
                  Text('1000개'),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
