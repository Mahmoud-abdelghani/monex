class ReminderTitle {
  final String value;

  ReminderTitle(this.value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('Reminder title cannot be empty');
    }
  }
}
