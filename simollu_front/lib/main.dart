
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/utils/fcm_setting.dart';
import 'package:simollu_front/utils/firebase_message.dart';
import 'package:simollu_front/utils/firebase_options.dart';
import 'package:simollu_front/utils/token_stamp.dart';

import 'package:simollu_front/viewmodels/main_view_model.dart';
import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/viewmodels/search_view_model.dart';
import 'package:simollu_front/viewmodels/user_view_model.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:simollu_front/root.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // final firebaseToken = await FirebaseMessaging.instance.getToken();
  // print('파이어토큰:$firebaseToken');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await fcmSetting();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  final getToken = TokenStamp();
  getToken.tokenStamp();
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var logger = Logger();
  logger.i(token);
  // FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  // String? firebaseToken = await fcmSetting();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final firebaseToken = await FirebaseMessaging.instance.getToken();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform
  // );

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
          Get.put(MainViewModel());
          Get.put(UserViewModel());
          Get.put(MapViewModel());
          Get.put(SearchViewModel());
          Get.put(MainViewModel());
        },
      ),
      // home: Root(),
      home: StartPage(),
    );
  }
}
