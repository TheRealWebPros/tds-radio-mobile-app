import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static List<Color> get buttomGradient => [
        const Color(0xAA4D1ABC).withOpacity(.5),
        Colors.purpleAccent.withOpacity(.5),
        Colors.purpleAccent,
      ];

  static Color get stationBackground => Colors.purpleAccent.withOpacity(.05);
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.yellow.withOpacity(1),
        cardTheme: const CardTheme(
          elevation: 1,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue.shade300,
        ),
        textTheme: const TextTheme(
            // headline1: TextStyle(color: Colors.black),
            // bodyText1: TextStyle(color: Colors.black),
            // bodyText2: TextStyle(color: Colors.black),
            // subtitle1: TextStyle(color: Colors.black),
            // subtitle2: TextStyle(color: Colors.black),
            // overline: TextStyle(color: Colors.black),
            ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black,
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.yellow,
              statusBarIconBrightness: Brightness.dark),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blue)
            .copyWith(background: Colors.yellow.withOpacity(1)));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      primaryColor: Colors.grey.shade900,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: Colors.blue.withOpacity(0.2),
        foregroundColor: Colors.white70,
      ),
      textTheme: const TextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,

        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        // foregroundColor: Colors.white,

        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.yellow,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.black.withOpacity(0.1),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.grey.shade900,
          // indicatorColor: Colors.grey.shade700,
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade900,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(background: Colors.grey.shade900),
    );
  }
}
