import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _isPressed = !_isPressed;
        });
        widget.onPressed();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: _isPressed ? Color(0xFFFFD200) : Colors.white,
        side: BorderSide(
          color: _isPressed ? Color(0xFFFFD200) : Colors.black54,
          width: 1.0,
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
          wordSpacing: 0,
          height: 1.0,
          shadows: [],
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
// Color(0xffFFD200)