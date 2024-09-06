import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/expense_summary.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:expense_tracker/summaryChart/icon_bubble.dart';
import 'package:expense_tracker/utils/format_number.dart';
import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.expenseSummary, {super.key});
  final ExpenseSummary expenseSummary;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
            top: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SummaryIconWithBuble(
              icon: getCategoryIcon(expenseSummary.title, 35),
              matches: expenseSummary.relatedMatches,
            ),
            const SizedBox(
              height: 40,
            ),
            StyledText('${formatNumber(expenseSummary.totalSpent)} \$',
                weight: FontWeight.w600,
                color:
                    Theme.of(context).textTheme.headlineMedium!.color as Color)
          ],
        ),
      ),
    );
  }
}
