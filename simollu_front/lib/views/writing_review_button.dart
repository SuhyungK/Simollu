import 'package:flutter/material.dart';

class WritingReviewButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  WritingReviewButton({required this.text, required this.onPressed});

  @override
  _WritingReviewButtonState createState() => _WritingReviewButtonState();
}

class _WritingReviewButtonState extends State<WritingReviewButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: OutlinedButton(
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
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 18, right: 18),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
              wordSpacing: 0,
              height: 1.0,
              shadows: [],
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
// Color(0xffFFD200)