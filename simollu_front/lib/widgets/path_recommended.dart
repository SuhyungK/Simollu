import 'package:flutter/material.dart';
import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/widgets/route_widget.dart';

class PathRecommended extends StatelessWidget {
  final Map<Place, List<PathSegment>> routes;
  final Function event;
  const PathRecommended({super.key, required this.routes, required this.event});

  @override
  Widget build(BuildContext context) {
    print(routes);
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: routes.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  event(entry.key);
                },
                child: RouteWidget(routes: entry.value, name: entry.key.name),
              ),
            );
          }).toList()),
    );
  }
}
