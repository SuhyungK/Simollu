import 'package:flutter/material.dart';
import 'package:simollu_front/widgets/custom_appBar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '알림 보기',
        leading: Image.asset('assets/backBtn.png'),
        actions: [Image.asset('assets/bell.png')],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12
                    )
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_outlined, size: 50,),
                      SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('맛있게 드셨나요?'),
                          Text('리뷰 남기고 포크를 받아보세요~!'),
                          Text('3일 전')
                        ],
                      ),
                      SizedBox(width: 60,),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
