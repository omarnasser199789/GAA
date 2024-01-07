import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// ----  Blue Theme  ----
const bluePrimary = Color(0xFFEC5252);
const blueAccent = Color(0xFF4D5BBF);
const blueBackground = Color(0xFFFFFFFF);

String primaryColorTypeString ="";
Color scaffoldBackgroundColorForLightTheme = const Color(0xFFF8F8F8);
Color scaffoldBackgroundColorForDarkTheme = const Color(0xFF0F0F0F);
Color cardColorForLightTheme = const Color(0xFFFFFFFF);
Color cardColorForDarkMode = const Color(0xFF2D2D2D);
final Color primaryColor = dotenv.env['primaryColor'] != null ? Color(int.parse(dotenv.env['primaryColor']!)) : Colors.blue; // Replace Colors.blue with a default color if needed


/// ----  lightTheme  ----

final ThemeData appTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  scaffoldBackgroundColor:scaffoldBackgroundColorForLightTheme,
  disabledColor: const Color.fromRGBO(18, 18, 18, 1),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  cardColor:cardColorForLightTheme,
  textTheme:  Typography(platform: TargetPlatform.iOS).black,
  snackBarTheme: const SnackBarThemeData(contentTextStyle:
  TextStyle(color:Color.fromRGBO(18, 18, 18, 1), fontFamily: "taleeq-bold")
  ),
);

/// ----  DarkTheme  ----

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor:scaffoldBackgroundColorForDarkTheme,
  primaryColor: primaryColor,
  disabledColor: const Color.fromRGBO(251, 250, 251, 1),
  canvasColor: Colors.white.withOpacity(0.87),
  cardColor: cardColorForDarkMode,
  textTheme:  Typography(platform: TargetPlatform.iOS).white,
  snackBarTheme: SnackBarThemeData(contentTextStyle:
  TextStyle(color:Colors.white.withOpacity(0.87),fontFamily: "taleeq-bold")
  ),
);

/// ----  BlueTheme  ----
final blueTheme = ThemeData(
  scaffoldBackgroundColor: blueBackground,
  disabledColor: const Color.fromRGBO(18, 18, 18, 1),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  cardColor: const Color.fromRGBO(255, 255, 255, 1),
);

/// ----  Spooky Theme  ----
const spookyPrimary = Color(0xFF000000);
const spookyAccent = Color(0xFFBB86FC);
const spookyBackground = Color(0xFF4A4A4A);
final spookyTheme = ThemeData(
  primaryColor: spookyPrimary,
  backgroundColor: spookyBackground,
  scaffoldBackgroundColor: spookyBackground,
  disabledColor: const Color.fromRGBO(18, 18, 18, 1),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  cardColor: const Color.fromRGBO(255, 255, 255, 1),
);

/// ----  Green Theme  ----
const greenPrimary = Color(0xFF4CAF50);
const greenAccent = Color(0xFF631739);
const greenBackground = Color(0xFFFFFFFF);
final greenTheme = ThemeData(
  primaryColor: greenPrimary,
  backgroundColor: greenBackground,
  scaffoldBackgroundColor: greenBackground,
  disabledColor: const Color.fromRGBO(18, 18, 18, 1),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  cardColor: const Color.fromRGBO(255, 255, 255, 1),
);

/// ----  Pink Theme  ----
const pinkPrimary = Color(0xFFE91E63);
const pinkAccent = Color(0xFF0C7D9C);
const pinkBackground = Color(0xFFFFFFFF);
final pinkTheme = ThemeData(
  primaryColor: pinkPrimary,
  backgroundColor: pinkBackground,
  scaffoldBackgroundColor: pinkBackground,
  disabledColor: const Color.fromRGBO(18, 18, 18, 1),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  cardColor: const Color.fromRGBO(255, 255, 255, 1),
);
