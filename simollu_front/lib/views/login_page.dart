import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/root.dart';
import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (int progress) {
        // Upadte loading bar
      },
      onPageFinished: (String url) async {
        if (url.contains('login-success')) {
          debugPrint('Page finished loading: $url');
          final uri = Uri.parse(url);
          final initial = bool.parse(uri.queryParameters['initial']!);
          final token = uri.queryParameters['token'];
          print('----------------------------- $token $initial');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token!);
          await prefs.setBool('initial', initial);
          if (initial == true) {
            Get.offAll(LikingThings());
          } else {
            Get.offAll(Root());
          }
        } else {
          debugPrint('Page finished loading: $url');
        }
      },
    ))
    ..loadRequest(
        Uri.parse('https://simollu.com/api/user/oauth2/authorization/kakao'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
