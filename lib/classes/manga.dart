
import 'package:Mangush/classes/chapter.dart';
import 'package:Mangush/classes/loadable.dart';
import 'package:Mangush/services/manga.dart';


class Manga extends Loadable {

  String id;
  String title;
  List categorys;
  String thumbnailUrl;

  String _artist;
  String get astist => requireFullDataProperty(_artist);
  String _author;
  String get author => requireFullDataProperty(_author);
  String _description;
  String get description => requireFullDataProperty(_description);
  List _chapters;
  List get chapters => requireFullDataProperty(_chapters);


  Manga({this.id, this.title, this.categorys, this.thumbnailUrl});

  Manga.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categorys = json['categorys'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Future loadFullData() {
    return MangaService.fetchFullMangaData(id)
    .then((data) {
      _artist = data[0];
      _author = data[1];
      _description = data[2];
      _chapters = data[3];
      super.loadFullData();
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categorys': categorys,
      'thumbnailUrl': thumbnailUrl
    };
  }

  Chapter getNextChapter(Chapter chapter) {
    int currentChapterIndex = chapters.indexOf(chapter);
    return chapters[currentChapterIndex - 1];
  }
}

