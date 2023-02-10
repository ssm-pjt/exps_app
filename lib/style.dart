import 'package:flutter/material.dart';

Color _primaryColor = Color(0xfff35a3a);

var theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: _primaryColor,
  backgroundColor: _primaryColor.withOpacity(0.8),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18),
    bodyText2: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.black87,
  )),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      elevation: 1,
      titleTextStyle: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: _primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: Colors.black38,
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
            decorationThickness: 1,
          ))),
  checkboxTheme: CheckboxThemeData(
// fillColor: MaterialStateProperty.all(Colors.black),
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(Colors.black54),
  ),
  listTileTheme: ListTileThemeData(
    selectedColor: _primaryColor,
  ),
  primaryTextTheme: TextTheme(bodyText1: TextStyle(overflow: TextOverflow.ellipsis)),
  colorScheme: ColorScheme.light(
    primary: _primaryColor,
  ),
);
