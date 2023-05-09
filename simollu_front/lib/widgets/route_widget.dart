import 'package:flutter/material.dart';

class RouteWidget extends StatelessWidget {
  final List<String> routes;
  final String name;
  const RouteWidget({super.key, required this.routes, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(0, 3),
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFAAAAAA),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text.rich(
              TextSpan(children: [
                ...List.generate(
                  routes.length,
                  (index) => TextSpan(
                    text: routes[index],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.arrow_right),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                    text: "도착",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
