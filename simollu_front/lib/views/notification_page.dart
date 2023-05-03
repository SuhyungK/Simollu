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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 15, 15),
                    horizontalTitleGap: 30,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('동래정 맛있게 드셨나요?'),
                        Text('리뷰 쓰고 포크 받아보세요~!'),
                        SizedBox(height: 8),
                      ],
                    ),
                    leading: Icon(Icons.edit_outlined, size: 40),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('3일 전'),
                    iconColor: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
