import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  final List<String> tabs;
  final List<Widget> tabViews;

  const CustomTabBar({
    Key? key,
    required this.length,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(child: _buildTabBarView()),
      ],
    );
  }

  // TabBar 제목 부분
  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
      child: TabBar(
        controller: _tabController,
        tabs: List<Widget>.generate(widget.length, (index) {
          return Tab(
              child: Text(
            widget.tabs[index],
            style: TextStyle(color: Colors.black, fontSize: 17),
          ));
        }),
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.all(5.0),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }

  // TabBar 내용 부분
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List<Widget>.generate(widget.length, (index) {
        return SingleChildScrollView(
          child: widget.tabViews[index],
        );
      }),
    );
  }
}
