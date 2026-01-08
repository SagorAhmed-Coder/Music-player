import 'package:flutter/material.dart';
import 'package:music_player_app/theme/dark_mode.dart';
import 'package:music_player_app/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //initially,light mode
  ThemeData _themeData = lightMode;

  //get theme
  ThemeData get  themeData => _themeData;

  //is dart mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    //update the ui
    notifyListeners();
  }

  //toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
