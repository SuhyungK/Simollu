
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:simollu_front/utils/firebase_options.dart';

Future<void> firebaseReceiveSetting() async {
  // 앱에서 Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // FCM 토큰 발급
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
}