import 'package:flutter/material.dart';

class MyPageEdit extends StatelessWidget {
  const MyPageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/cat.jpg"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          print("프로필 사진 변경");
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "닉네임",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  print('내 정보 수정');
                },
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFFFFD200),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '수정하기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
