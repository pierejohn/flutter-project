



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

var defultColor=HexColor('#268f14');
var DefultColor=HexColor('#268f14');


MaterialColor hexToMaterialColor(Color color) {
  return MaterialColor(
    color.value,
    <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color,
      600: color.withOpacity(0.6),
      700: color.withOpacity(0.7),
      800: color.withOpacity(0.8),
      900: color.withOpacity(0.9),
    },
  );
}
