
import 'package:Mangush/classes/manga.dart';
import 'package:Mangush/utils/jsonStorage.dart';


class UserMangaService {
  static String _filePath = 'userManga.json';

  static List _userManga;
  static List get userManga => _userManga;

  static Future load() {
    return loadJson(_filePath)
    .catchError((_) {
      return [];
    }).then((loadedUserManga) {
      _userManga = loadedUserManga.map((mangaJson) => Manga.fromJson(mangaJson)).toList();
    });
  }

  static bool isUserManga(Manga manga) {
    return _userManga.contains(manga);
  }

  static Future addManga(Manga manga) {
    _userManga.add(manga);
    List newUserManga = List();
    _userManga.forEach((manga) {
      if (!newUserManga.contains(manga)) {
        newUserManga.add(manga);
      }
    });
    _userManga = newUserManga;
    return _dumpManga();
  }

  static Future removeManga(Manga manga) {
    _userManga = _userManga.where((userManga) => userManga.id != manga.id).toList();
    return _dumpManga();
  }


  static Future _dumpManga() {
    List userMangaJson = _userManga.map((manga) => manga.toJson()).toList();
    return dumpJson(userMangaJson, _filePath);
  }
}
