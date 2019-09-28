
import "package:path_provider/path_provider.dart";
import 'dart:io';
import 'dart:convert';


Future<dynamic> loadJson(String path) {
  return _getLocalFile(path)
  .then((file) {
    return file.readAsString();
  }).then((content) {
    return jsonDecode(content);
  });
}


Future dumpJson(dynamic jsonData, String path) {
  String data = jsonEncode(jsonData);
  return _getLocalFile(path)
  .then((file) {
    return file.writeAsString(data);
  });
}


Future<File> _getLocalFile(String path) {
  return getApplicationDocumentsDirectory()
  .then((dir) {
    String fullPath = '${dir.path}/$path';
    return File(fullPath);
  });
}

