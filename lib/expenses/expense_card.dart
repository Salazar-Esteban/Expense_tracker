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
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 227, 226, 226),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              StyledText(
                expense.title,
                color: blackContrast,
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
                    color: blackContrast,
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
    );
  }
}
