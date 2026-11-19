import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';

/// Totals and counts for a single month, calculated from the raw lists
/// delivered by the existing income and expense streams.
class MonthlySummary {
  final double incomeTotal;
  final int incomeCount;
  final double expenseTotal;
  final int expenseCount;

  const MonthlySummary({
    required this.incomeTotal,
    required this.incomeCount,
    required this.expenseTotal,
    required this.expenseCount,
  });

  factory MonthlySummary.forMonth({
    required DateTime month,
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    var incomeTotal = 0.0;
    var incomeCount = 0;
    for (final income in incomes) {
      if (_isInMonth(income.date, month)) {
        incomeTotal += income.amount;
        incomeCount++;
      }
    }

    var expenseTotal = 0.0;
    var expenseCount = 0;
    for (final expense in expenses) {
      if (_isInMonth(expense.date, month)) {
        expenseTotal += expense.amount;
        expenseCount++;
      }
    }

    return MonthlySummary(
      incomeTotal: incomeTotal,
      incomeCount: incomeCount,
      expenseTotal: expenseTotal,
      expenseCount: expenseCount,
    );
  }

  static bool _isInMonth(DateTime date, DateTime month) {
    final local = date.toLocal();
    return local.year == month.year && local.month == month.month;
  }

  double get netCashFlow => incomeTotal - expenseTotal;

  int get transactionCount => incomeCount + expenseCount;

  bool get isEmpty => transactionCount == 0;

  double get _combinedTotal => incomeTotal + expenseTotal;

  double get incomeShare =>
      _combinedTotal <= 0 ? 0 : incomeTotal / _combinedTotal;

  double get expenseShare =>
      _combinedTotal <= 0 ? 0 : expenseTotal / _combinedTotal;
}
