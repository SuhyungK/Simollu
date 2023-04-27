import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simollu_front/views/liking_things_page.dart';
import 'package:simollu_front/views/my_page.dart';
import 'package:simollu_front/views/tmp_page.dart';
import 'package:simollu_front/widgets/nav_bar.dart';

class RootController extends GetxController {
  RxInt rootPageIndex = 0.obs;

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
  }
}

class Root extends GetView<RootController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Test'),
        ),
        body: IndexedStack(
          index: controller.rootPageIndex.value,
          children: [
            TmpPage(),
            LikingThings(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: NavBar(
          controller: controller,
        ),
      ),
    );
  }
}
