import 'package:intl/intl.dart';

String formatNumber(double number) =>
    NumberFormat('#,##0.00', 'en_us').format(number);
