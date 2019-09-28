
import 'dart:ui';

import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/screens/manga/chapterList.dart';
import 'package:Mangush/theme.dart';
import 'package:Mangush/widgets/loadingState.dart';

import 'package:flutter/material.dart';


class MangaScreen extends StatefulWidget {
  final Manga manga;

  MangaScreen(this.manga);

  @override
  _MangaScreenState createState() => _MangaScreenState();
}

class _MangaScreenState extends LoadingState<MangaScreen> {

  @override
  void initState() {
    super.initState();
    widget.manga.loadFullData()
    .then((_) {
      switchLoadStatus(false);
    });
  }

  Widget dimmedBackgroundImageConatiner({ImageProvider provider, Widget child}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.8,
              child: Container(color: seconderyColor),
            ),
            child
          ],
        ) 
      ),
    );
  }

  @override
  Widget loadingBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.manga.title),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget loadedBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.manga.title),
      ),
      body: dimmedBackgroundImageConatiner(
        provider: NetworkImage(widget.manga.thumbnailUrl),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChapterList(
                manga: widget.manga
              ),
            ),
          ],
        )
      )
    );
  }
}
