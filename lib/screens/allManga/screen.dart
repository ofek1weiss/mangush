
import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/widgets/loadingState.dart';
import 'package:Mangush/widgets/mangaList.dart';
import 'package:flutter/material.dart';
import 'package:Mangush/services/manga.dart';


class AllMangaScreen extends StatefulWidget {
  @override
  _AllMangaScreenState createState() => _AllMangaScreenState();
}

class _AllMangaScreenState extends LoadingState<AllMangaScreen> {

  String searchTerm = '';
  List<Manga> mangas = [];
  AppBar searchBar;

  _AllMangaScreenState() {
    searchBar = AppBar(
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Search'
        ),
        onChanged: (newVal) {
          switchLoadStatus(true);
          searchTerm = newVal;
          loadMangas().then((_) => switchLoadStatus(false));
        },
      ),
    );
    loadMangas().then((_) => switchLoadStatus(false));
  }

  Future loadMangas() {
    return MangaService.findMangas(filter: searchTerm)
    .then((mangaList) {
      setState(() { 
        mangas = mangaList;
      });
    });
  }

  @override
  Widget loadingBuild(BuildContext context) {
    return Scaffold(
      appBar: searchBar,
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }

  @override
  Widget loadedBuild(BuildContext context) {
    return Scaffold(
      appBar: searchBar,
      body: mangas.length > 0 ? 
        MangaList(mangas) : 
        Center(child: Text('No Manga Found'),)
    );
  }
}
