import 'package:flutter/material.dart';

class Restaurant {
  final String id;
  final String iamgePath;
  final String name;
  final double likePercentages;
  final String kind;
  final String location;
  bool isLike;

  Restaurant({
    required this.id,
    required this.iamgePath,
    required this.name,
    required this.likePercentages,
    required this.kind,
    required this.location,
    required this.isLike,
  });
}

class RestaurantListItem extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantListItem({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantListItem> createState() => _RestaurantListItemState();
}

class _RestaurantListItemState extends State<RestaurantListItem> {
  bool _isLiked = false;

  @override
  void initState() {
    _isLiked = widget.restaurant.isLike;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(widget.restaurant.iamgePath),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Color(0xFFF6D000),
                      size: 24,
                    ),
                    Text(
                      "기다릴만해요 ${widget.restaurant.likePercentages}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6D000),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.restaurant.kind}, ${widget.restaurant.location}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFaaaaaa),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print(_isLiked);
              setState(() {
                _isLiked = !_isLiked;
                widget.restaurant.isLike = _isLiked;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: _isLiked
                  ? Icon(
                      Icons.favorite,
                      size: 32,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      size: 32,
                      color: Colors.red,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
