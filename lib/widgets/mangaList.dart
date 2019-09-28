
import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/services/userManga.dart';
import 'package:Mangush/theme.dart';
import 'package:Mangush/widgets/mangaListItem.dart';
import 'package:flutter/material.dart';

class MangaList extends StatelessWidget {

  final List mangas;

  MangaList(this.mangas);

  void onMangaLongPress(BuildContext context, Manga manga) {
    bool isFavorite = UserMangaService.isUserManga(manga);

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            ListTile(
              title: Text(isFavorite ? 'Remove From Favorites' : 'Add To Favorites'),
              trailing: Icon(isFavorite ? Icons.remove : Icons.add),
              onTap: () {
                isFavorite ? UserMangaService.removeManga(manga) : UserMangaService.addManga(manga);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Information'),
              trailing: Icon(Icons.info_outline),
              onTap: () {
                manga.loadFullData()
                .then((_) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        contentPadding: EdgeInsets.all(10),
                        backgroundColor: accentColor,
                        children: <Widget>[
                          Text(
                            manga.description,
                          )
                        ],
                      );
                    }
                  );
                });
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mangas.length * 2,
      itemBuilder: (context, index) {
        if (index % 2 == 1) {
          return Divider(
            color: primaryColor,
          );
        }
        Manga manga = mangas[(index / 2).round()];
        return MangaListItem(
          manga,
          onLongPress: () => onMangaLongPress(context, manga),
        );
      }
    );
  }
}