import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';

/// The inclusive range of months the user is allowed to browse.
///
/// The lower bound is the month of the oldest income or expense, and the
/// upper bound is the current month. Future months are never selectable.
class MonthRange {
  final DateTime earliest;
  final DateTime latest;
  final bool hasTransactions;

  const MonthRange._({
    required this.earliest,
    required this.latest,
    required this.hasTransactions,
  });

  factory MonthRange.fromTransactions({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
    required DateTime now,
  }) {
    final latest = firstDayOfMonth(now);
    DateTime? oldest;

    for (final income in incomes) {
      final date = income.date.toLocal();
      if (oldest == null || date.isBefore(oldest)) oldest = date;
    }
    for (final expense in expenses) {
      final date = expense.date.toLocal();
      if (oldest == null || date.isBefore(oldest)) oldest = date;
    }

    if (oldest == null) {
      return MonthRange._(
        earliest: latest,
        latest: latest,
        hasTransactions: false,
      );
    }

    final earliest = firstDayOfMonth(oldest);
    return MonthRange._(
      earliest: earliest.isAfter(latest) ? latest : earliest,
      latest: latest,
      hasTransactions: true,
    );
  }

  static DateTime firstDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month);

  static DateTime shift(DateTime month, int deltaMonths) =>
      DateTime(month.year, month.month + deltaMonths);

  int get monthCount =>
      (latest.year - earliest.year) * 12 + latest.month - earliest.month + 1;

  bool contains(DateTime month) {
    final normalized = firstDayOfMonth(month);
    return !normalized.isBefore(earliest) && !normalized.isAfter(latest);
  }

  DateTime clamp(DateTime month) {
    final normalized = firstDayOfMonth(month);
    if (normalized.isBefore(earliest)) return earliest;
    if (normalized.isAfter(latest)) return latest;
    return normalized;
  }

  bool canGoPrevious(DateTime month) => firstDayOfMonth(month).isAfter(earliest);

  bool canGoNext(DateTime month) => firstDayOfMonth(month).isBefore(latest);
}
