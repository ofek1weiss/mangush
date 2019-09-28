

import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/screens/chapter/screen.dart';
import 'package:Mangush/theme.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {

  final Manga manga;

  ChapterList({this.manga});

  Widget circularText(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: primaryColor
        ),  
      ),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.all(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: manga.chapters.map((chapter) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
                width: 1
              )
            )
          ),
          child: ListTile(
            leading: circularText(_prettyNumString(chapter.number)),
            title: Text(
              chapter.title ?? '',
              style: TextStyle(
                color: primaryColor
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChapterScreen(chapter, manga)
            )),
          ),
        );
      }).toList(),
    );
  }
}

String _prettyNumString(num number) {
  if (number % 1 == 0) {
    return number.toInt().toString();
  }
  return number.toString();
}
