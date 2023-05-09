import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simollu_front/models/path_segment.dart';

import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  bool _locationPermission = false;
  late Position _currentPosition;
  Set<Marker> _markers = {};
  late StreamSubscription<Position> positionStreamSubscription;
  List<PathSegment> _pathList = [];
  List<Polyline> _polylineList = [];

  final LatLng _center = const LatLng(37.5013068, 127.0396597);
  final LatLng _arrive = const LatLng(37.5047984, 127.0434318);

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: LatLng(_arrive.latitude, _arrive.longitude),
    ));
    void _listening() async {
      await _getCurrentLocation();
      if (_locationPermission) {
        _pathList =
            await Provider.of<MapViewModel>(context, listen: false).findPaths(
          LatLng(_currentPosition.latitude, _currentPosition.longitude),
          _arrive,
          "",
        );

        List<Polyline> polylineList = [];
        int polylineId = 0;
        for (PathSegment path in _pathList) {
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
          print(path.index.toString() +
              " " +
              path.coordinates.toString() +
              " " +
              path.distance.toString() +
              " " +
              path.time.toString());
        }
        setState(() {
          _polylineList = polylineList;
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
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _markers.add(Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(position.latitude, position.longitude),
        ));
      });
    }).catchError((e) {
      print(e);
    });

    setState(() {
      _locationPermission = true;
    });
  }

  void _onLocationChanged(Position position) async {
    setState(() {
      _currentPosition = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(position.latitude, position.longitude),
      ));
      _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: _arrive,
      ));
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 19,
    )));
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
                                zoom: 19,
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
          SizedBox(
            height: 400,
            child: CustomTabBar(
              length: 2,
              tabs: ['추천 경로', '검색'],
              tabViews: [
                Container(child: Text("추천 경로")),
                Container(child: Text("검색")),
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
