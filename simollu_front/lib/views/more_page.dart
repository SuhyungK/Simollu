import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("공지사항");
            },
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "공지사항",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("설정");
            },
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "설정",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("고객센터");
            },
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "고객센터",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("정보");
            },
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "정보",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
