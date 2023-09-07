import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  Future<void> setShowAge(bool isShowAge) {
    return prefs.setBool('isShowAge', isShowAge);
  }

  Future<void> setShowDistance(bool isShowDistance) {
    return prefs.setBool('isShowDistance', isShowDistance);
  }

  Future<void> setShowGenotype(bool isShowGenotype) {
    return prefs.setBool('isShowGenotype', isShowGenotype);
  }

  bool? getShowAge() {
    return prefs.getBool('isShowAge');
  }

  bool? getShowDistance() {
    return prefs.getBool('isShowDistance');
  }

  bool? getShowGenotype() {
    return prefs.getBool('isShowGenotype');
  }
}
