
import 'package:Mangush/classes/chapter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Mangush/classes/manga.dart';


const String _metadataBaseUrl = 'https://www.mangaeden.com/api';
const String _imagaBaseUrl = 'https://cdn.mangaeden.com/mangasimg';
const String _listPath = 'list/0';
const String _mangaPath = 'manga';
const String _chapterPath = 'chapter';

class MangaService {

  static http.Client _httpClient = http.Client();
  static List<Manga> _mangas;

  static Future<List<Manga>> findMangas({String filter: ''}) {
    filter = filter.toLowerCase();

    return Future.value()
    .then((_) {
      if (_mangas == null) {
        return _fetchMangas();
      }
    }).then((_) {
      if (filter == '') {
        return _mangas;
      }
      return _mangas.where((manga) {
        return manga.title.toLowerCase().contains(filter);
      }).toList();
    });
  }

  static Future _fetchMangas() {
    return _httpClient.get('$_metadataBaseUrl/$_listPath/')
    .then((response) {
      List mangaJsons = jsonDecode(response.body)['manga'];
      _mangas = mangaJsons.map((mangaJson) {
        return Manga(
          id: mangaJson['i'],
          categorys: mangaJson['c'],
          title: mangaJson['t'],
          thumbnailUrl: '$_imagaBaseUrl/${mangaJson["im"]}'
        );
      }).toList();
    });
  }

  static Future<List> fetchFullMangaData(String mangaId) {
    return _httpClient.get('$_metadataBaseUrl/$_mangaPath/$mangaId')
    .then((response) {
      Map<String, dynamic> mangaJson = jsonDecode(response.body);
      return [
        mangaJson['artist'],
        mangaJson['author'],
        mangaJson['description'],
        mangaJson['chapters'].map((chapter) {
          return Chapter(
            id: chapter[3],
            title: chapter[2],
            number: chapter[0].toDouble()
          );
        }).toList()
      ];
    });
  }

  static Future<List> fetchFullChapterData(String chapterId) {
    return _httpClient.get('$_metadataBaseUrl/$_chapterPath/$chapterId')
    .then((response) {
      List pageLists = jsonDecode(response.body)['images'];
      List urlList = pageLists.map((p) => '$_imagaBaseUrl/${p[1]}').toList();
      return urlList.reversed.toList();
    });
  }

}
