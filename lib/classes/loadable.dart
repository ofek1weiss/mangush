

class FullDataNotLoaded implements Exception {}


class Loadable {  
  bool _hasFullData = false;

  T requireFullDataProperty<T>(T value) {
    if (!_hasFullData) {
      throw new FullDataNotLoaded();
    }
    return value;
  }

  void loadFullData() {
    _hasFullData = true;
  }
}
