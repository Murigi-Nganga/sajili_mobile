import 'package:flutter/material.dart';

AppBarTheme _appBarTheme = const AppBarTheme(
  centerTitle: true,
  elevation: 0,
);

PageTransitionsTheme _pageTransitionsTheme =
    const PageTransitionsTheme(builders: {
  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
  TargetPlatform.windows: CupertinoPageTransitionsBuilder()
});

ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: 12,
      ),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  ),
);

ThemeData appTheme = ThemeData(
  appBarTheme: _appBarTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  fontFamily: 'Quicksand',
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.blue[800],
    secondary: Colors.blueGrey[600],
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  pageTransitionsTheme: _pageTransitionsTheme,
);
