import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

var icons = [
  "assets/home.svg",
  "assets/search.svg",
  "assets/person.svg",
  "assets/more.svg",
];

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int selectedIdx = 0;

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
          ...List.generate(
            icons.length,
            (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIdx = index;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      height: selectedIdx == index ? 50.0 : 0.0,
                      width: selectedIdx == index ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIdx == index ? Color(0xFFFFD200) : null,
                      ),
                      curve: Curves.fastOutSlowIn,
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        colorFilter: selectedIdx == index
                            ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                            : null,
                        icons[index],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
