class Place {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Place.fromJSON(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['place_name'],
        this.address = json['road_address_name'],
        this.lat = double.parse(json['y']),
        this.lng = double.parse(json['x']);
}
