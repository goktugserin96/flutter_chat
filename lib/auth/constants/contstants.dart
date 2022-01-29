import 'package:flutter/material.dart';

ThemeData themeLogin = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(300, 40)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )))),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.only(top: 15),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
    ),
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black)));
