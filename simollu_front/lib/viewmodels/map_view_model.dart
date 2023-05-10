import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/services/kakao_map_api.dart';
import 'package:simollu_front/services/t_map_api.dart';

enum LoadingStatus { completed, loading, empty }

class MapViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  LoadingStatus placeLoadingStatus = LoadingStatus.empty;
  List<PathSegment> paths = [];
  List<Place> places = [];

  Future<List<PathSegment>> findPaths(
      LatLng start, LatLng end, String passList) async {
    this.paths = await TMapAPI().findPaths(start, end, passList);
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    this.loadingStatus =
        this.paths.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    return this.paths;
  }

  Future<List<Place>> getPlaces(LatLng dest, String keyword) async {
    this.places = await KakaoMapAPI().getPlaces(dest, keyword);
    placeLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    placeLoadingStatus =
        this.places.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;

    return this.places;
  }
}
