import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static final ShrHelper shrHelper = ShrHelper();
  Future<void> setTheme(bool theme) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("theme", theme);
  }

  Future<bool?> getTheme() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? theme = shr.getBool("theme");
    return theme;
  }
}
