import 'package:expense_tracker/expenses/expense_card.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.removeExpenseHandler, {super.key});
  final void Function(String id) removeExpenseHandler;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final currentExpense = expenses[index];
        return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => removeExpenseHandler(currentExpense.id),
            key: ValueKey(expenses[index]),
            child: ExpenseCard(currentExpense));
      },
    );
  }
}
