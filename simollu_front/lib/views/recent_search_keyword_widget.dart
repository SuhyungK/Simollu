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
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: _clearRecentSearches,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text('최근 검색어 삭제'),
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              children: _recentSearches.map((query) {
                return Row(
                  children: [
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