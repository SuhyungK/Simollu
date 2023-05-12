import 'package:flutter/material.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/widgets/route_widget.dart';

class PathSearchResult extends StatelessWidget {
  final Map<Place, List<PathSegment>> routes;
  final Function clickEvent;
  final Function search;
  const PathSearchResult({
    super.key,
    required this.routes,
    required this.clickEvent,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            child: TextField(
              decoration: InputDecoration(hintText: "놀거리 검색.."),
              onSubmitted: (keyword) => search(keyword),
            ),
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: routes.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    clickEvent(entry.key);
                  },
                  child: RouteWidget(routes: entry.value, wayPoint: entry.key),
                ),
              );
            }).toList()),
      ],
    );
  }
}
