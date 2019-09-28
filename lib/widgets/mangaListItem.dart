
import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/screens/manga/screen.dart';
import 'package:flutter/material.dart';

class MangaListItem extends StatelessWidget {

  final Manga manga;
  final Function onLongPress;

  MangaListItem(this.manga, {this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToManga(context),
      onLongPress: onLongPress,
      child: Container (
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              height: 140,
              child: Image.network(manga.thumbnailUrl),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(manga.title),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  Text(manga.categorys.join(', '))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToManga(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MangaScreen(manga)
    ));
  }
}
