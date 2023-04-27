import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20),
              Image.asset(
                  'assets/logo.png',
                  width: 300,
              ),
              Image.asset(
                'assets/kakao_login_large_wide 1.png'
              )
            ],
          ),
        ),
      ),
    );
  }
}
