import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget homeIcon = SvgPicture.asset(
  "assets/home.svg",
  width: 100,
  height: 100,
);

Widget searchIcon = SvgPicture.asset(
  "assets/search.svg",
  width: 100,
  height: 100,
);

Widget personIcon = SvgPicture.asset(
  "assets/person.svg",
  width: 100,
  height: 100,
);

Widget moreIcon = SvgPicture.asset(
  "assets/more.svg",
  width: 100,
  height: 100,
);

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: homeIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: searchIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: personIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: moreIcon,
          ),
        ],
      ),
    );
  }
}
