import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:simollu_front/views/my_page_edit.dart';
import 'package:simollu_front/views/writing_review_page.dart';
import 'package:simollu_front/root.dart';
import './views/my_page.dart';
import 'widgets/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // 추가
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      initialBinding: BindingsBuilder(
        () {
          Get.put(RootController());
        },
      ),
      // home: Root(),
      home: StartPage(),
    );
  }
}
