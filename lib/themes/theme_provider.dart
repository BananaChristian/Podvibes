import 'package:flutter/material.dart';
import 'package:podvibes/themes/themes.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData ){
      _themeData=themeData;
      notifyListeners();
  }

  void toggleThemes(){
    if(_themeData==lightMode){
      themeData=darkMode;
    }else{
      themeData=lightMode;
    }
  }
}