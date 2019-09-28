
import 'package:Mangush/classes/chapter.dart';
import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/widgets/loadingState.dart';
import 'package:flutter/material.dart';

class ChapterScreen extends StatefulWidget {

  final Chapter chapter;
  final Manga manga;

  ChapterScreen(this.chapter, this.manga);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends LoadingState<ChapterScreen> {

  PageController controller;
  Chapter chapter;

  @override
  void initState() {
    controller = PageController();
    chapter = widget.chapter;
    super.initState();
    chapter.loadFullData()
    .then((_) {
      switchLoadStatus(false);
    });
  }

  void switchChapter(context) {
    NavigatorState navigator = Navigator.of(context);
    Chapter nextChapter = widget.manga.getNextChapter(chapter);
    navigator.pop();
    navigator.push(MaterialPageRoute(builder: (context) {
      return ChapterScreen(nextChapter, widget.manga);
    }));
  }

  Widget chapterItemBuilder(context, index) {
    if (index == chapter.length) {
      return Material(child: InkWell(
        child: Center(child: Text('Go To Next Chapter')),
        onTap: () => switchChapter(context)
      ));
    }
    else {
      String url = chapter.pageUrls[index];
      return Image.network(url);
    }
  }

  @override
  Widget loadedBuild(BuildContext context) {
    return PageView.builder(
      reverse: true,
      itemCount: chapter.length + 1,
      controller: controller,
      itemBuilder: chapterItemBuilder
    );
  }
}
