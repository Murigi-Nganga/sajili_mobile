import 'package:flutter/material.dart';

const _appColors = {
  'kPrimary': Colors.indigo,
  'kSecondary': Colors.blue,
  'kBackground': Color(0xFFF5F5F5) //whitesmoke
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
  ),
);

ThemeData appTheme = ThemeData(
  appBarTheme: _appBarTheme,
  scaffoldBackgroundColor: _appColors['kBackground'],
  elevatedButtonTheme: _elevatedButtonTheme,
  fontFamily: 'Quicksand',
  colorScheme: const ColorScheme.light().copyWith(
    primary: _appColors['kPrimary'],
    secondary: _appColors['kSecondary'],
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
