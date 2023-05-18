import 'package:flutter/material.dart';

const _appColors = {
  'kPrimary': Colors.indigo,
  'kSecondary': Colors.blue,
  'kTertiary': Color.fromARGB(255, 36, 58, 97)
};

const AppBarTheme _appBarTheme = AppBarTheme(
  centerTitle: true,
  elevation: 0,
);

ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: 12,
      ),
    ),
    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    )),
  ),
);

ThemeData appTheme = ThemeData(
  appBarTheme: _appBarTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  fontFamily: 'Quicksand',
  colorScheme: const ColorScheme.light().copyWith(
    primary: _appColors['kPrimary'],
    secondary: _appColors['kSecondary'],
    tertiary: _appColors['tertiary']
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
