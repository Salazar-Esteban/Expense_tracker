import 'package:expense_tracker/models/expense.dart';

final List<Expense> expensesListData = [
  Expense(
      amount: 9000,
      category: ExpenseCategory.intertaiment,
      date: DateTime.now(),
      title: 'Cinema '),
  Expense(
      amount: 25490,
      date: DateTime.now(),
      title: 'HBO Suscription',
      category: ExpenseCategory.home),
  Expense(
      amount: 31100,
      date: DateTime.now(),
      title: 'Netflix Suscription',
      category: ExpenseCategory.home),
  Expense(
      amount: 109.990,
      date: DateTime.now(),
      title: 'Omint Suscription',
      category: ExpenseCategory.health),
];
