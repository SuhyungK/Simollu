import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late Position _currentPosition;
  Set<Marker> _markers = {};
  late StreamSubscription<Position> positionStreamSubscription;

  final LatLng _center = const LatLng(37.5013068, 127.0396597);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startListening();
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
    if (permission == LocationPermission.denied) {
      return Future.error('위치 권한 거부');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부됨.');
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
  }

  void _onLocationChanged(Position position) async {
    setState(() {
      _currentPosition = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(position.latitude, position.longitude),
      ));
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 18,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
        ),
        zoomControlsEnabled: false,
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 18,
            ),
          ));
        },
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
