import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/services/kakao_map_api.dart';
import 'package:simollu_front/services/t_map_api.dart';
import 'package:simollu_front/widgets/custom_marker.dart';

enum LoadingStatus { completed, loading, empty }

class MapViewModel extends GetxController {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  LoadingStatus placeLoadingStatus = LoadingStatus.empty;

  RxList<PathSegment> paths = <PathSegment>[].obs;
  RxList<Place> placeList = <Place>[].obs;
  RxList<Place> searchPlaceList = <Place>[].obs;
  RxList<Polyline> polylineList = <Polyline>[].obs;
  RxMap<Place, List<Polyline>> polylineMap = {
    Place(
      address: "",
      lat: 0,
      lng: 0,
      id: "default",
      name: "default",
    ): <Polyline>[],
  }.obs;

  Rx<Position?> currentPosition = null.obs;

  Rx<LatLng> start = Rx<LatLng>(LatLng(37.5013068, 127.0396597));
  Rx<LatLng> destination = LatLng(37.5047984, 127.0434318).obs;
  Rx<LatLng> center = LatLng(37.5013068, 127.0396597).obs;
  RxMap<String, List<String>> routes = {
    "default": <String>[],
  }.obs;

  RxMap<Place, List<PathSegment>> pathMap = {
    Place(
      address: "",
      lat: 0,
      lng: 0,
      id: "default",
      name: "default",
    ): <PathSegment>[],
  }.obs;

  RxMap<Place, List<PathSegment>> searchPathMap = {
    Place(
      address: "",
      lat: 0,
      lng: 0,
      id: "default",
      name: "default",
    ): <PathSegment>[],
  }.obs;

  RxSet<Marker> markers = <Marker>{}.obs;

  void addMarker() async {
    Marker destinationMarker = await CustomMarker(
            markerId: "destination",
            latLng: destination.value,
            type: MarkerType.destination)
        .getMarker();

    markers.add(destinationMarker);
    final Position? position = currentPosition.value;

    Marker start = await CustomMarker(
            markerId: "start", latLng: _start, type: MarkerType.start)
        .getMarker();

    _markers.add(start);
  }

  Future<List<PathSegment>> findPaths(
      LatLng start, LatLng end, String passList) async {
    paths = await TMapAPI().findPaths(start, end, passList);
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    loadingStatus =
        paths.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    return paths;
  }

  Future<List<Place>> getPlaces(LatLng dest, String keyword) async {
    places = await KakaoMapAPI().getPlaces(dest, keyword);
    placeLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    placeLoadingStatus =
        places.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;

    return places;
  }
}
