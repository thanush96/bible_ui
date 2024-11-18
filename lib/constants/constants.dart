// constants.dart
import 'package:flutter/material.dart';

const LinearGradient globalGradient = LinearGradient(
  colors: [
    Color(0xFF000000), // #000000
    Color(0xFF3533CD), // #3533CD
    Color.fromRGBO(80, 77, 255, 0.678), // rgba(53, 51, 205, 0.68)
  ],
  stops: [
    0.095,
    0.456,
    0.80,
  ], // Define the position of each color stop
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
