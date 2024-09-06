import 'package:expense_tracker/screens/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
);
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: kDarkColorScheme.onSurface),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: kDarkColorScheme.onSurface),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.secondaryContainer),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.surfaceDim,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.only(bottom: 15),
          color: kDarkColorScheme.onSecondary,
        ),
        textTheme: const TextTheme().copyWith(
          headlineSmall:
              TextStyle(color: kDarkColorScheme.onSecondaryContainer),
          headlineMedium: TextStyle(color: kDarkColorScheme.onSecondary),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: kDarkColorScheme.onInverseSurface),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: kDarkColorScheme.onInverseSurface),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.secondaryContainer),
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.only(bottom: 15),
          color: kDarkColorScheme.onSecondaryContainer,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
        ),
        textTheme: const TextTheme().copyWith(
          headlineSmall: TextStyle(color: kColorScheme.onPrimaryContainer),
          headlineMedium: TextStyle(color: kDarkColorScheme.onSecondary),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const ExpenceScreen(title: 'Expenses Tracker'),
    );
  }
}
