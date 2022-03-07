import 'package:flutter/material.dart';

class PColors {
  static const int _primary = 0xFF263284;

  static const int _secondary = 0xFFFFBF40;

  static const MaterialColor primarySwatch = MaterialColor(
    _primary,
    <int, Color>{
      50: Color(0xFFD3D7F2),
      100: Color(0xFF7B87D9),
      200: Color(0xFF4E5FCC),
      300: Color(0xFF3343AF),
      400: Color(0xFF263284),
      500: Color(_primary),
      600: Color(0xFF192157),
      700: Color(0xFF131941),
      800: Color(0xFF0D112B),
      900: Color(0xFF060816),
    },
  );

  static const MaterialColor secondarySwatch = MaterialColor(
    _primary,
    <int, Color>{
      50: Color(0xFFFFF5E0),
      100: Color(0xFFFFE0A1),
      200: Color(0xFFFFD581),
      300: Color(0xFFFFCB62),
      400: Color(_secondary),
      500: Color(0xFFFFAE0D),
      600: Color(0xFFD68F00),
      700: Color(0xFFA16B00),
      800: Color(0xFF6B4700),
      900: Color(0xFF362400),
    },
  );
}
