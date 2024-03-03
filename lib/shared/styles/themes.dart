import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

// var defultColor = HexColor("#d8a5b4");
 var defultColor = HexColor("#268f14");

var materialColor = hexToMaterialColor(defultColor);

ThemeData darktheme=ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )
  ),
  // scaffoldBackgroundColor: HexColor('333739'),
  scaffoldBackgroundColor: HexColor('#268f14'),
  primarySwatch:  materialColor,

  appBarTheme: AppBarTheme(



      iconTheme: const IconThemeData(color: Colors.white,),

      systemOverlayStyle: SystemUiOverlayStyle(
        // statusBarColor: HexColor('333739'),
        statusBarColor: HexColor('#268f14'),
        statusBarBrightness:Brightness.light,
      ),
      // backgroundColor: HexColor('333739'),
      backgroundColor: HexColor('#268f14'),
      elevation: 0,
      titleTextStyle: const TextStyle(
        color:Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor('#268f14'),
    elevation: 20,
    unselectedItemColor: Colors.white,
    // backgroundColor: HexColor('333739'),
    backgroundColor: HexColor('#268f14'),
  ),

);
ThemeData lightheme=ThemeData(
    textTheme: const TextTheme(


        bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.3
        )

    ),
    primarySwatch: materialColor,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),

      iconTheme: IconThemeData(color: Colors.black,),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness:Brightness.light,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    fontFamily: 'Jannah',

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,

      elevation: 20,
    )
);
