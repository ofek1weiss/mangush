
import 'package:flutter/material.dart';

Color accentColor = Colors.deepPurple;
Color primaryColor = Colors.white;
Color seconderyColor = Color.fromARGB(255, 20, 20, 30);
double defaultSize = 16;


ThemeData get appThemeData => ThemeData(
  primarySwatch: accentColor,
  canvasColor: seconderyColor,
  textTheme: TextTheme(
    body1: TextStyle(
      color: primaryColor,
      fontSize: defaultSize
    )
  )
);