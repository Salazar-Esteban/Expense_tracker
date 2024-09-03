import 'package:expense_tracker/models/expense_summary.dart';
import 'package:expense_tracker/summaryChart/summary_item.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart(this.summaries, {super.key});
  final List<ExpenseSummary> summaries;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 227, 226, 226),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(2, -2), // changes position of shadow
            ),
          ],
          color: Color.fromRGBO(255, 255, 255, 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...summaries.map(
            (summary) => SummaryItem(summary),
          ),
        ],
      ),
    );
  }
}
