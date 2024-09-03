import 'package:expense_tracker/colors/colors.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense(this.addExpenseHandler, {super.key});
  final void Function(Expense expense) addExpenseHandler;
  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleCtr = TextEditingController();
  final _amountCtr = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory? _selectedCategory = ExpenseCategory.home;

  void _closeModal(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: now,
    );
    if (datePicked != null) {
      setState(() {
        _selectedDate = datePicked;
      });
    }
  }

  void _handleDropdown(ExpenseCategory? value) {
    if (_selectedCategory == null) return;
    setState(() {
      _selectedCategory = value;
    });
  }

  void _handleSubmit() {
    final amount = double.tryParse(_amountCtr.text);
    final isAmountValid = amount == null || amount <= 0;
    final isDateValid = _selectedDate == null;
    final isTitleValid = _titleCtr.text.trim().isEmpty;

    if (isTitleValid || isAmountValid || isDateValid) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const StyledHeader('Validation error', color: blackContrast),
            content: const StyledText(
              "Invalid value in one of the fields ",
              color: blackContrast,
            ),
            actions: [
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => Navigator.pop(ctx),
                  child: const StyledText(
                    'Okay',
                    weight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        },
      );
      return;
    }
    widget.addExpenseHandler(Expense(
        amount: amount,
        title: _titleCtr.text,
        category: _selectedCategory!,
        date: _selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleCtr.dispose();
    _amountCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedCategory);
    print(_selectedDate);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLength: 12,
            controller: _titleCtr,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _amountCtr,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StyledText(
                      _selectedDate == null
                          ? 'Select date'
                          : formatterDate.format(_selectedDate!),
                      color: blackContrast,
                      weight: FontWeight.w500,
                    ),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          DropdownButton(
              value: _selectedCategory,
              items: ExpenseCategory.values.map((category) {
                return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        getCategoryIcon(category, 20),
                        const SizedBox(
                          width: 15,
                        ),
                        StyledText(category.name.toUpperCase(),
                            color: blackContrast),
                      ],
                    ));
              }).toList(),
              onChanged: (value) => _handleDropdown(value)),
          Expanded(
            child: Row(
              children: [
                TextButton(
                  onPressed: () => _closeModal(context),
                  child: const Text('Cancel'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Save expense'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
