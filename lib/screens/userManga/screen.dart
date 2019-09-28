
import 'package:Mangush/screens/allManga/screen.dart';
import 'package:Mangush/services/userManga.dart';
import 'package:Mangush/theme.dart';
import 'package:Mangush/widgets/loadingState.dart';
import 'package:Mangush/widgets/mangaList.dart';
import 'package:flutter/material.dart';


class UserMangaScreen extends StatefulWidget {
  @override
  _UserMangaScreenState createState() => _UserMangaScreenState();
}

class _UserMangaScreenState extends LoadingState<UserMangaScreen> {

  List mangas = [];

  _UserMangaScreenState() {
    UserMangaService.load()
    .then((_) {
      mangas = UserMangaService.userManga;
      switchLoadStatus(false);
    });
  }

  Future reload() {
    setState(() {
      mangas = UserMangaService.userManga;
    });
    return Future.delayed(Duration(milliseconds: 200));
  }

  @override
  Widget loadedBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Library'),
      ),
      body: mangas.length > 0 ? 
        RefreshIndicator(
          onRefresh: reload,
          backgroundColor: accentColor,
          color: primaryColor,
          child:  MangaList(mangas),
        ) : 
        Center(child: Text('No Manga Found')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        child: Icon(Icons.add, color: primaryColor),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AllMangaScreen();
          }));
        },
      )
    );
  }
}