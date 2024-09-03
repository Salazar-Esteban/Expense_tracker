import 'package:expense_tracker/screens/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 91, 163)),
        useMaterial3: true,
      ),
      home: const ExpenceScreen(title: 'Expenses Tracker'),
    );
  }
}
