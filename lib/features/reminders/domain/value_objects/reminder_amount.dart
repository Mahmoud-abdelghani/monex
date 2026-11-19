class ReminderAmount {
  final double value;

  ReminderAmount(this.value) {
    if (!value.isFinite || value < 0) {
      throw ArgumentError(
        'Reminder amount must be a finite non-negative number',
      );
    }
  }
}