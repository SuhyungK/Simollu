import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/services/tmap_api.dart';

enum LoadingStatus { completed, loading, empty }

class MapViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<PathSegment> paths = [];

  Future<List<PathSegment>> findPaths(
      LatLng start, LatLng end, String passList) async {
    this.paths = await TMapAPI().findPaths(start, end, passList);
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    this.loadingStatus =
        this.paths.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    return this.paths;
  }
}
