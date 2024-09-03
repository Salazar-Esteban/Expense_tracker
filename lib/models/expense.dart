import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatterDate = DateFormat.yMd();

enum ExpenseCategory { food, travel, home, intertaiment, health }

Icon getCategoryIcon(ExpenseCategory category, double size) {
  return Icon(
    categoryIcons[category],
    color: categoryIconColor[category],
    size: size.isFinite ? size : 20,
  );
}

const categoryIconColor = {
  ExpenseCategory.food: Colors.lightGreen,
  ExpenseCategory.health: Colors.redAccent,
  ExpenseCategory.home: Color.fromARGB(255, 245, 207, 56),
  ExpenseCategory.intertaiment: Colors.blue,
  ExpenseCategory.travel: Colors.amber,
};
const categoryIcons = {
  ExpenseCategory.food: Icons.dining_sharp,
  ExpenseCategory.home: Icons.home_outlined,
  ExpenseCategory.intertaiment: Icons.gamepad_outlined,
  ExpenseCategory.travel: Icons.travel_explore_outlined,
  ExpenseCategory.health: Icons.health_and_safety_outlined
};

class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  })  : id = uuid.v4(),
        categoryIcon = categoryIcons[category];

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final IconData? categoryIcon;

  Icon get getCategoryIcon {
    return Icon(
      categoryIcons[category],
      color: categoryIconColor[category],
    );
  }

  String get getFormattedDate {
    return formatterDate.format(date);
  }
}
