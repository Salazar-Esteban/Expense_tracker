import 'package:expense_tracker/models/expense.dart';

class ExpenseSummary {
  ExpenseSummary(
      {required this.title,
      required this.relatedMatches,
      required this.totalSpent});
  final ExpenseCategory title;
  int relatedMatches;
  double totalSpent;
}
