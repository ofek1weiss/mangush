
import 'package:Mangush/screens/userManga/screen.dart';
import 'package:Mangush/theme.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangush',
      theme: appThemeData,
      home: UserMangaScreen(),
    );
  }
}

