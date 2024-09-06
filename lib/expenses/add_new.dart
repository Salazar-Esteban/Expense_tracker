import 'package:expense_tracker/colors/colors.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/styled_text.dart';
import 'package:flutter/material.dart';

SizedBox gap({double y = 0, double x = 0}) {
  return SizedBox(
    height: y,
    width: x,
  );
}

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
    final keywordSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        var maxW = constraints.maxWidth;

        var titleInputW = Flexible(
          child: TextField(
            maxLength: 12,
            controller: _titleCtr,
            style: TextStyle(
                color:
                    Theme.of(context).textTheme.headlineSmall!.color as Color),
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
        );

        var amountInputW = Flexible(
          child: TextField(
            style: TextStyle(
                color:
                    Theme.of(context).textTheme.headlineSmall!.color as Color),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _amountCtr,
            decoration: const InputDecoration(
              label: Text('Amount'),
              prefixText: '\$ ',
            ),
          ),
        );
        var dropDownCats = DropdownButton(
            value: _selectedCategory,
            items: ExpenseCategory.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    getCategoryIcon(category, 20),
                    gap(x: 10),
                    StyledText(
                      category.name.toUpperCase(),
                      color: Theme.of(context)
                          .dropdownMenuTheme
                          .textStyle!
                          .color as Color,
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: _handleDropdown);
        var datePickerW = Row(
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
        );
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 40, 15, keywordSpace + 16),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ajusta el tamaño de la columna al mínimo necesario
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (maxW >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleInputW,
                        gap(x: 15),
                        amountInputW,
                      ],
                    )
                  else
                    titleInputW,
                  if (maxW >= 600)
                    Row(
                      children: [dropDownCats, const Spacer(), datePickerW],
                    )
                  else
                    Row(
                      children: [amountInputW, const Spacer(), datePickerW],
                    ),
                  gap(y: 25),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () => _closeModal(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _handleSubmit,
                        child: const Text('Save expense'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
