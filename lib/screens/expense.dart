import 'package:expense_tracker/expenses/add_new.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expenses/expenses_list.dart';
import 'package:expense_tracker/models/expense_summary.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:expense_tracker/summaryChart/summary_chart.dart';
import 'package:flutter/material.dart';

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

class ExpenceScreen extends StatefulWidget {
  const ExpenceScreen({super.key, required this.title});
  final String title;

  @override
  State<ExpenceScreen> createState() => ExpenseState();
}

class ExpenseState extends State<ExpenceScreen> {
  List<Expense> expenses = expensesListData;

  Map<ExpenseCategory, ExpenseSummary> calculateExpenseSummary() {
    Map<ExpenseCategory, ExpenseSummary> summary = {};

    for (var i = 0; i < expenses.length; i++) {
      final currentExpense = expenses[i];
      final expenseCategory = currentExpense.category;
      //  Iterates the  expenses list and add a new entry in the summary map with the key as expense category only  the first time  that find that specific category, and set the expenseSummary as value
      //  Register the spent money and accumulate the total in each category
      if (!summary.containsKey(expenseCategory)) {
        summary[expenseCategory] = ExpenseSummary(
            title: expenseCategory,
            relatedMatches: 1,
            totalSpent: currentExpense.amount);
      } else {
        // Otherwise increment the  relatedMatches property
        summary[expenseCategory]?.relatedMatches++;
        // Increment de accumulated total spent
        summary[expenseCategory]?.totalSpent += currentExpense.amount;
      }
    }
    return summary;
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddNewExpense(_addExpenseHandler));
  }

  void _addExpenseHandler(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpenseHandler(String id) {
    setState(() {
      expenses.removeWhere((expense) => expense.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseSummary = calculateExpenseSummary().values.toList();
    print(expenseSummary);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 142, 255),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
            color: Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryChart(expenseSummary),
            const SizedBox(
              height: 50,
            ),
            StyledHeader(
              'Total expenses: ${expenses.length}',
              color: const Color.fromARGB(255, 15, 84, 126),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: ExpensesList(expensesListData, _removeExpenseHandler)),
          ],
        ),
      ),
    );
  }
}
