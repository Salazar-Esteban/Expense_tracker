import 'package:expense_tracker/models/expense_summary.dart';
import 'package:expense_tracker/summaryChart/summary_item.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart(this.summaries, {super.key});
  final List<ExpenseSummary> summaries;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...summaries.map(
              (summary) => SummaryItem(summary),
            ),
          ],
        ),
      ),
    );
  }
}
