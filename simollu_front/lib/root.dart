import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/views/more_page.dart';
import 'package:simollu_front/views/my_page.dart';
import 'package:simollu_front/views/search_page.dart';
import 'package:simollu_front/views/tmp_page.dart';
import 'package:simollu_front/widgets/nav_bar.dart';
import 'package:simollu_front/utils/sstack.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();
  // 현재 보고 있는  페이지 인덱스
  RxInt rootPageIndex = 0.obs;
  List<RxBool> isMainPages = [true.obs, true.obs, true.obs, true.obs];
  // 페이지 타이틀을 스택으로 관리
  List<Sstack<RxString>> rootPageTitles = [
    Sstack<RxString>(["".obs]),
    Sstack<RxString>(["검색하기".obs]),
    Sstack<RxString>(["마이 페이지".obs]),
    Sstack<RxString>(["더 보기".obs]),
  ];
  RxBool visibleBell = true.obs;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> searchKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> myPageKey = GlobalKey<NavigatorState>();

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
  }

  Future<bool> onWillPop() async {
    rootPageTitles[rootPageIndex.value].pop();
    return !(await navigatorKey.currentState!.maybePop() || await searchKey.currentState!.maybePop() ||
        await myPageKey.currentState!.maybePop());
  }

  void setRootPageTitles(String title) {
    rootPageTitles[rootPageIndex.value].push(title.obs);
  }

  void setIsMainPage(bool flag) {
    isMainPages[rootPageIndex.value](flag);
  }

  void back() {
    onWillPop();
    if (rootPageTitles[rootPageIndex.value].length == 1) {
      setIsMainPage(true);
    }
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
              controller.rootPageTitles[controller.rootPageIndex.value]
                  .peek()
                  .value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            leading:
                controller.isMainPages[controller.rootPageIndex.value].value
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
            actions: [
              controller.visibleBell.value
                  ? GestureDetector(
                      onTap: () {
                        print("알림 클릭");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    )
                  : Container(),
            ],
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
              Navigator(
                key: controller.searchKey,
                  onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                      builder: (context) => const SearchPage());
                }
              ),
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
