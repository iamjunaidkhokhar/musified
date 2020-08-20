import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget pausePlay(IconData faIcon) {
  double firstOffset = 5.0;
  double secondOffset = -5.0;
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orangeAccent,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0XFF4a4a4a),
            offset: Offset(firstOffset, firstOffset),
            blurRadius: 6.0,
          ),
          BoxShadow(
            color: Color(0XFF404040),
            offset: Offset(secondOffset, secondOffset),
            blurRadius: 6.0,
          ),
        ]),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0,
        ),
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: Alignment.topLeft, colors: [Colors.red, Colors.orange]),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: FaIcon(
          faIcon,
          color: Colors.white70,
          size: 30,
        ),
      ),
    ),
  );
}
