import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/presentation/widgets/reminder_overflow_menu.dart';

class ReminderCard extends StatelessWidget {
  final ReminderEntity reminder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onReschedule;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onEdit,
    required this.onDelete,
    required this.onReschedule,
  });

  static const Color _darkText = Color(0xFF1A1A2E);
  static const Color _greyText = Color(0xFF6B7280);

  String get _frequencyLabel => switch (reminder.frequency) {
    ContributionPeriod.none => 'One-time',
    ContributionPeriod.daily => 'Daily',
    ContributionPeriod.weekly => 'Weekly',
    ContributionPeriod.monthly => 'Monthly',
    ContributionPeriod.yearly => 'Yearly',
  };

  String get _amountFormatted {
    final isWhole = reminder.amount.value.truncateToDouble() == reminder.amount;
    return '\$${reminder.amount.value.toStringAsFixed(isWhole ? 0 : 2)}';
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM yyyy');
    final horizontal = ScreenSize.width * 0.05;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: ScreenSize.height * 0.012,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starts ${fmt.format(reminder.scheduleDate.value)}',
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.0165,
                        color: _darkText,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.004),
                    Text(
                      reminder.title.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.0205,
                        fontWeight: FontWeight.w700,
                        color: _darkText,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.004),
                    Row(
                      children: [
                        Text(
                          _amountFormatted,
                          style: TextStyle(
                            fontSize: ScreenSize.height * 0.0175,
                            fontWeight: FontWeight.w600,
                            color: _greyText,
                          ),
                        ),
                        SizedBox(width: ScreenSize.width * 0.025),
                        Icon(
                          Icons.repeat_rounded,
                          size: ScreenSize.height * 0.016,
                          color: _greyText,
                        ),
                        SizedBox(width: ScreenSize.width * 0.01),
                        Text(
                          _frequencyLabel,
                          style: TextStyle(
                            fontSize: ScreenSize.height * 0.015,
                            color: _greyText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: ScreenSize.width * 0.07,
                    height: ScreenSize.height * 0.03,
                    child: ReminderOverflowMenu(
                      onEdit: onEdit,
                      onDelete: onDelete,
                      onReschedule: onReschedule,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.006),
                  Text(
                    'Due on',
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.014,
                      fontWeight: FontWeight.w700,
                      color: _greyText,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.002),
                  Text(
                    fmt.format(reminder.deadline.value),
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.014,
                      color: _greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          indent: horizontal,
          endIndent: horizontal,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
