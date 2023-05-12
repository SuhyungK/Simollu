import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MarkerType {
  start,
  destination,
  waypoint,
  myLocation,
}

class CustomMarker {
  final String markerId;
  final LatLng latLng;
  final MarkerType type;

  const CustomMarker({
    required this.markerId,
    required this.latLng,
    required this.type,
  });

  Future<Marker> getMarker() async {
    // late BitmapDescriptor image;
    switch (type) {
      case MarkerType.start:
        // icon = Icons.directions_bike;
        break;
      case MarkerType.destination:
        // image = await BitmapDescriptor.fromAssetImage(
        //   ImageConfiguration(size: Size(48, 48)),
        //   "assets/icons/destination.png",
        // );
        break;
      case MarkerType.waypoint:
        // icon = Icons.location_history;
        break;
      case MarkerType.myLocation:
        // icon = Icons.my_location;
        break;
    }

    return Marker(
      markerId: MarkerId(markerId),
      position: latLng,
      // icon: image,
    );
  }
}
