import 'package:flutter/material.dart';
import 'package:simollu_front/views/search_page.dart';

class RecentSearchKeywordWidget extends StatefulWidget {
  const RecentSearchKeywordWidget({Key? key}) : super(key: key);

  @override
  _RecentSearchKeywordWidgetState createState() => _RecentSearchKeywordWidgetState();
}

class _RecentSearchKeywordWidgetState extends State<RecentSearchKeywordWidget> {
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final recentSearches = await RecentSearches.load();
    setState(() {
      _recentSearches = recentSearches;
    });
  }

  Future<void> _clearRecentSearches() async {
    await RecentSearches.clear();
    setState(() {
      _recentSearches = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 35,
                child: OutlinedButton(
                  onPressed: _clearRecentSearches,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.black38,
                      width: 0.9,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 원하는 radius 값으로 설정
                    ),
                  ),
                  child: const Text('모두 삭제',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                      wordSpacing: 0,
                      height: 1.0,
                      shadows: [],
                      decoration: TextDecoration.none,
                    ),),
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              children: _recentSearches.map((query) {
                return Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.history),
                    const SizedBox(width: 8),
                    Text(query),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}