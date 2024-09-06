import 'package:expense_tracker/data/expenses.dart';
import 'package:expense_tracker/expenses/add_new.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expenses/expenses_list.dart';
import 'package:expense_tracker/models/expense_summary.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:expense_tracker/summaryChart/summary_chart.dart';
import 'package:flutter/material.dart';

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
        useSafeArea: true,
        context: context,
        builder: (ctx) => AddNewExpense(_addExpenseHandler));
  }

  void _addExpenseHandler(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(String id) {
    final expense = expenses.firstWhere((expense) => expense.id == id);
    final expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.removeWhere((expense) => expense.id == id);
    });
//  Show undo message with undo option
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: const StyledText("Expense removed !"),
      backgroundColor: Colors.blue,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => _undoRemoveHandler(expense, expenseIndex),
      ),
    ));
  }

  void _undoRemoveHandler(Expense expenseForRecovering, int index) {
    setState(() {
      expenses.insert(index, expenseForRecovering);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;
    double width = mediaQ.width;
    double height = mediaQ.height;
    print({width, height});
    final expenseSummary = calculateExpenseSummary().values.toList();
    final mainContent = expenses.isEmpty
        ? Center(
            child: StyledHeader(
            'No expenses found',
            size: 20,
            color: Theme.of(context).textTheme.headlineSmall!.color as Color,
          ))
        : Expanded(
            child: ExpensesList(expensesListData, _removeExpense),
          );
    print(expenseSummary);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        child: width < 600
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SummaryChart(expenseSummary),
                  const SizedBox(
                    height: 50,
                  ),
                  expenses.isNotEmpty
                      ? StyledHeader(
                          'Total expenses: ${expenses.length}',
                          color: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .color as Color,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  mainContent,
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: SummaryChart(expenseSummary)),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(child: mainContent),
                ],
              ),
      ),
    );
  }
}
