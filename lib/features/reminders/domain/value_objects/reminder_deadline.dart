class ReminderDeadline {
  final DateTime value;

  ReminderDeadline(this.value) {
    if (value.isBefore(DateTime.now())) {
      throw ArgumentError('Reminder deadline cannot be in the past');
    }
  }
}
