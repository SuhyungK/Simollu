import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';

import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/widgets/custom_marker.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';
import 'package:simollu_front/widgets/path_recommended.dart';
import 'package:simollu_front/widgets/path_search_result.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 지도 카메라 컨트롤
  final Completer<GoogleMapController> _controller = Completer();

  late StreamSubscription<Position> positionStreamSubscription;

  bool locationPermission = false;

  @override
  void initState() {
    super.initState();

    // _markers.add(Marker(
    //   markerId: MarkerId("destination"),
    //   position: _arrive,
    // ));

    void _listening() async {
      await _getCurrentLocation();
      if (_locationPermission) {
        addMarker();
        // 관심 검색하는 부분
        List<Place> newPlaceList =
            await Provider.of<MapViewModel>(context, listen: false)
                .getPlaces(_arrive, "PC방");

        Map<Place, List<PathSegment>> newPathMap = {};
        Map<Place, List<Polyline>> newPolylineMap = {};

        int polylineId = 0;

        if (newPlaceList.isNotEmpty) {
          for (Place place in newPlaceList) {
            List<PathSegment> pathList =
                await Provider.of<MapViewModel>(context, listen: false)
                    .findPaths(
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
              _arrive,
              place.lng.toString() + "," + place.lat.toString(),
            );
            newPathMap[place] = pathList;

            List<Polyline> polylineList = [];
            for (PathSegment path in pathList) {
              for (int i = 0; i < path.coordinates.length - 1; i++) {
                polylineList.add(Polyline(
                  polylineId: PolylineId(polylineId.toString()),
                  points: [
                    LatLng(path.coordinates[i][1], path.coordinates[i][0]),
                    LatLng(
                        path.coordinates[i + 1][1], path.coordinates[i + 1][0])
                  ], // 시작점과 끝점 좌표
                  color: Colors.red, // 선 색상
                  width: 5,
                ));
                polylineId++;
              }
            }
            newPolylineMap[place] = polylineList;
          }
        } else {
          List<PathSegment> pathList =
              await Provider.of<MapViewModel>(context, listen: false).findPaths(
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  _arrive,
                  "");

          List<Polyline> polylineList = [];
          for (PathSegment path in pathList) {
            for (int i = 0; i < path.coordinates.length - 1; i++) {
              polylineList.add(Polyline(
                polylineId: PolylineId(polylineId.toString()),
                points: [
                  LatLng(path.coordinates[i][1], path.coordinates[i][0]),
                  LatLng(path.coordinates[i + 1][1], path.coordinates[i + 1][0])
                ], // 시작점과 끝점 좌표
                color: Colors.red, // 선 색상
                width: 5,
              ));
              polylineId++;
            }
          }
          Place place = Place(
            address: "",
            lat: 0,
            lng: 0,
            id: "",
            name: "동래정",
          );
          newPolylineMap[place] = polylineList;
          newPathMap[place] = pathList;
        }

        setState(() {
          _polylineMap = newPolylineMap;
          placeList = newPlaceList;
          pathMap = newPathMap;
        });
        _startListening();
      }
    }

    _listening();
  }

  @override
  void dispose() {
    positionStreamSubscription.cancel();
    super.dispose();
  }

  void _startListening() {
    final locationSettings =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _onLocationChanged(position);
    });
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // return Future.error('위치 권한 거부');
      return;
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      _currentPosition = position;
      Marker myLocation = await CustomMarker(
              markerId: "myLocation",
              latLng:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              type: MarkerType.myLocation)
          .getMarker();
      setState(() {
        _markers.add(myLocation);
      });
    }).catchError((e) {
      print(e);
    });

    setState(() {
      _locationPermission = true;
    });
  }

  void _onLocationChanged(Position position) async {
    _currentPosition = position;
    Marker myLocation = await CustomMarker(
            markerId: "myLocation",
            latLng:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            type: MarkerType.myLocation)
        .getMarker();
    setState(() {
      _markers.remove(_markers
          .firstWhere((marker) => marker.markerId == MarkerId('myLocation')));

      _markers.add(myLocation);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 19,
    )));
  }

  void onClickPath(Place key) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng((_currentPosition.latitude + _arrive.latitude) / 2,
            (_currentPosition.longitude + _arrive.longitude) / 2),
        zoom: 16.0,
      ),
    ));

    Marker? waypoint = _markers.firstWhere(
      (marker) => marker.markerId == MarkerId('waypoint'),
      orElse: () => Marker(
        markerId: MarkerId('default'),
      ),
    );
    if (waypoint.markerId != MarkerId('default')) {
      _markers.remove(waypoint);
    }
    waypoint = await CustomMarker(
            markerId: "waypoint",
            latLng: LatLng(key.lat, key.lng),
            type: MarkerType.waypoint)
        .getMarker();
    _markers.add(waypoint);

    setState(() {
      _polylineList = _polylineMap[key]!;
    });
  }

  void search(String keyword) async {
    List<Place> newSearchPlaceList =
        await Provider.of<MapViewModel>(context, listen: false)
            .getPlaces(_arrive, keyword);
    Map<Place, List<PathSegment>> newSearchPathMap = {};
    Map<Place, List<Polyline>> newPolylineMap = _polylineMap;

    int polylineId = 0;
    for (Place place in newSearchPlaceList) {
      List<PathSegment> pathList =
          await Provider.of<MapViewModel>(context, listen: false).findPaths(
        LatLng(_currentPosition.latitude, _currentPosition.longitude),
        _arrive,
        place.lng.toString() + "," + place.lat.toString(),
      );
      newSearchPathMap[place] = pathList;

      List<Polyline> polylineList = [];

      for (PathSegment path in pathList) {
        for (int i = 0; i < path.coordinates.length - 1; i++) {
          polylineList.add(Polyline(
            polylineId: PolylineId(polylineId.toString()),
            points: [
              LatLng(path.coordinates[i][1], path.coordinates[i][0]),
              LatLng(path.coordinates[i + 1][1], path.coordinates[i + 1][0])
            ], // 시작점과 끝점 좌표
            color: Colors.red, // 선 색상
            width: 5,
          ));
          polylineId++;
        }
      }
      newPolylineMap[place] = polylineList;
    }

    Marker waypoint = _markers.firstWhere(
      (marker) => marker.markerId == MarkerId('waypoint'),
      orElse: () => Marker(markerId: MarkerId('default')),
    );

    setState(() {
      if (waypoint.markerId != MarkerId('default')) {
        _markers.remove(waypoint);
      }
      _polylineList = [];
      _polylineMap = newPolylineMap;
      searchPlaceList = newSearchPlaceList;
      searchPathMap = newSearchPathMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '대기번호',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 8,
                      ),
                    ),
                    TextSpan(
                      text: '15',
                      style: TextStyle(
                        color: Color(0xFFFFD200),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '예상대기시간',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 8,
                      ),
                    ),
                    TextSpan(
                      text: '60분',
                      style: TextStyle(
                        color: Color(0xFFFFD200),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  polylines: Set<Polyline>.of(_polylineList),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 19.0,
                  ),
                  zoomControlsEnabled: false,
                  markers: _markers,
                  mapType: MapType.terrain,
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFFFFD200),
                    splashColor: Color(0xFFFFD200),
                    onPressed: _locationPermission
                        ? () async {
                            final GoogleMapController controller =
                                await _controller.future;
                            controller
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(_currentPosition.latitude,
                                    _currentPosition.longitude),
                                zoom: 19.0,
                              ),
                            ));
                          }
                        : null,
                    child: Icon(Icons.location_searching),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomTabBar(
              length: 2,
              tabs: ['추천 경로', '검색'],
              tabViews: [
                PathRecommended(
                  routes: pathMap,
                  event: onClickPath,
                ),
                PathSearchResult(
                  routes: searchPathMap,
                  clickEvent: onClickPath,
                  search: search,
                ),
              ],
            ),
          ),
          // SingleChildScrollView(
          // ),
        ],
      ),
    );
  }
}
