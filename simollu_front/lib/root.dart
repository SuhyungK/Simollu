import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simollu_front/views/more_page.dart';
import 'package:simollu_front/views/my_page.dart';
import 'package:simollu_front/views/search_page.dart';
import 'package:simollu_front/views/tmp_page.dart';
import 'package:simollu_front/widgets/nav_bar.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();
  RxInt rootPageIndex = 0.obs;
  RxString rootPageTitle = "".obs;
  RxBool isMainPage = true.obs;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> myPageKey = GlobalKey<NavigatorState>();

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
    if (index == 0) {
      setRootPageTitle("");
    } else if (index == 1) {
      setRootPageTitle("검색하기");
    } else if (index == 2) {
      setRootPageTitle("마이 페이지");
    } else if (index == 3) {
      setRootPageTitle("더보기");
    }
  }

  Future<bool> onWillPop() async {
    if (rootPageIndex.value == 0) {
      setRootPageTitle("");
    } else if (rootPageIndex.value == 1) {
      setRootPageTitle("검색하기");
    } else if (rootPageIndex.value == 2) {
      setRootPageTitle("마이 페이지");
    } else if (rootPageIndex.value == 3) {
      setRootPageTitle("더보기");
    }
    return !(await navigatorKey.currentState!.maybePop() ||
        await myPageKey.currentState!.maybePop());
  }

  void setRootPageTitle(String title) {
    rootPageTitle(title);
  }

  void setIsMainPage(bool flag) {
    isMainPage(flag);
  }

  void back() {
    setIsMainPage(true);
    onWillPop();
  }
}

class Root extends GetView<RootController> {
  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              controller.rootPageTitle.value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            leading: controller.isMainPage.value
                ? Container()
                : GestureDetector(
                    onTap: () {
                      controller.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
          ),
          body: IndexedStack(
            index: controller.rootPageIndex.value,
            children: [
              Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                      builder: (context) => const TmpPage());
                },
              ),
              SearchPage(),
              Navigator(
                key: controller.myPageKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                      builder: (context) => const MyPage());
                },
              ),
              MorePage()
            ],
          ),
          bottomNavigationBar: NavBar(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
