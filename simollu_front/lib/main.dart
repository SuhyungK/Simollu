import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:simollu_front/viewmodels/main_view_model.dart';
import 'package:simollu_front/viewmodels/search_view_model.dart';
import 'package:simollu_front/viewmodels/user_view_model.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:simollu_front/root.dart';

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
          Get.put(UserViewModel());
          Get.put(SearchViewModel());
          Get.put(MainViewModel());
        },
      ),
      // home: Root(),
      home: StartPage(),
    );
  }
}
