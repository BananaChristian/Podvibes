import 'package:flutter/material.dart';

ThemeData lightMode =ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.white, 
    primary: Color.fromARGB(255, 230, 223, 223), 
    inversePrimary: Colors.black
    )
);

ThemeData darkMode=ThemeData(
  colorScheme: const ColorScheme.dark(
  surface:Color.fromARGB(255, 0, 0, 0),
  primary:Color.fromARGB(255, 37, 36, 36),
  inversePrimary: Colors.white,
  ) 
);