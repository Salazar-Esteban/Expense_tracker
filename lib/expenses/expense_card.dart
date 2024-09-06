import 'package:expense_tracker/colors/colors.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:expense_tracker/utils/format_number.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                StyledText(
                  expense.title,
                  color:
                      Theme.of(context).textTheme.headlineSmall!.color as Color,
                ),
                const Spacer(),
                Column(
                  children: [
                    expense.getCategoryIcon,
                    const SizedBox(
                      height: 5,
                    ),
                    StyledText(
                      expense.getFormattedDate,
                      color: Theme.of(context).textTheme.headlineSmall!.color
                          as Color,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StyledText(
              '${formatNumber(expense.amount)} \$',
              color: primaryBlue,
              size: 16,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
