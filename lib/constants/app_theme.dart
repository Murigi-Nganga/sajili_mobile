import 'package:flutter/material.dart';

const _lecAppColors = {
  'kPrimary': Colors.indigo,
  'kSecondary': Colors.blue,
  'kBackground': Color(0xFFF5F5F5) //whitesmoke
};

const _studAppColors = {
  'kPrimary': Colors.teal,
  'kSecondary': Colors.cyan,
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
  scaffoldBackgroundColor: _studAppColors['kBackground'],
  elevatedButtonTheme: _elevatedButtonTheme,
  fontFamily: 'Gorodita',
  colorScheme: const ColorScheme.light().copyWith(
    primary: _studAppColors['kPrimary'],
    secondary: _studAppColors['kSecondary'],
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
