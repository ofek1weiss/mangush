
import 'package:Mangush/classes/loadable.dart';
import 'package:Mangush/services/manga.dart';


class Chapter extends Loadable {
  
  String _id;
  double number;
  String title;

  List _pageUrls;
  List get pageUrls => requireFullDataProperty(_pageUrls);
  int get length => requireFullDataProperty(_pageUrls.length);

  Chapter({String id, this.number, this.title}) {
    _id = id;
  }

  Future loadFullData() {
    return MangaService.fetchFullChapterData(_id)
    .then((serverPageUrls) {
      _pageUrls = serverPageUrls;
      super.loadFullData();
    });
  }
}
