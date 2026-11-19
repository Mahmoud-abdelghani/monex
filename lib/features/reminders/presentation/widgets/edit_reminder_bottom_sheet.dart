import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/presentation/cubit/update_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/widgets/reminder_form_fields.dart';

class EditReminderBottomSheet extends StatefulWidget {
  final ReminderEntity reminder;

  const EditReminderBottomSheet({super.key, required this.reminder});

  static Future<void> show(
    BuildContext context, {
    required ReminderEntity reminder,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<UpdateReminderCubit>(context),
        child: EditReminderBottomSheet(reminder: reminder),
      ),
    );
  }

  @override
  State<EditReminderBottomSheet> createState() =>
      _EditReminderBottomSheetState();
}

class _EditReminderBottomSheetState extends State<EditReminderBottomSheet> {
  late final ReminderFormController _ctrl;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _ctrl = ReminderFormController();
    _ctrl.addListener(_detectChanges);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_detectChanges);
    _ctrl.dispose();
    super.dispose();
  }

  void _detectChanges() {
    final reminder = widget.reminder;

    final changed =
        (_ctrl.title.isNotEmpty && _ctrl.title != reminder.title.value) ||
        (_ctrl.amount != null && _ctrl.amount != reminder.amount.value) ||
        (_ctrl.frequency != null && _ctrl.frequency != reminder.frequency) ||
        (_ctrl.deadline != null &&
            !_isSameMinute(_ctrl.deadline!, reminder.deadline.value));

    if (changed != _hasChanged) {
      setState(() => _hasChanged = changed);
    }
  }

  bool _isSameMinute(DateTime a, DateTime b) =>
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute;

  void _handleSave() {
    final reminder = widget.reminder;

    context.read<UpdateReminderCubit>().updatereminder(
      id: reminder.id,
      title: _ctrl.title.isNotEmpty ? _ctrl.title : reminder.title.value,
      amount: _ctrl.amount ?? reminder.amount.value,
      frequency: _ctrl.frequency ?? reminder.frequency,
      // The first schedule is fixed after creation.
      scheduleDate: reminder.scheduleDate.value,
      deadline: _ctrl.deadline ?? reminder.deadline.value,
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.04,
            vertical: ScreenSize.height * 0.015,
          ),
          decoration: BoxDecoration(
            color: Colors.redAccent.shade700,
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.014),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              SizedBox(width: ScreenSize.width * 0.025),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.height * 0.016,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<UpdateReminderCubit, UpdateReminderState>(
      listener: (ctx, state) {
        if (state is UpdateReminderSuccess) {
          Navigator.of(context).pop();
        } else if (state is UpdateReminderFailure) {
          _showErrorSnackbar(ctx, state.message);
        }
      },
      builder: (ctx, state) {
        final isLoading = state is UpdateReminderLoading;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenSize.height * 0.028),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ScreenSize.height * 0.015),
                  child: Container(
                    width: ScreenSize.width * 0.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.02,
                    ScreenSize.width * 0.04,
                    ScreenSize.height * 0.01,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Edit Reminder',
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.024,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: isLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.grey.shade500,
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: AbsorbPointer(
                    absorbing: isLoading,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReminderFormFields(
                            controller: _ctrl,
                            initialTitle: widget.reminder.title.value,
                            initialAmount: widget.reminder.amount.value,
                            initialFrequency: widget.reminder.frequency,
                            initialScheduleDate:
                                widget.reminder.scheduleDate.value,
                            initialDeadline: widget.reminder.deadline.value,
                            enableScheduleDate: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.02,
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.03,
                  ),
                  child: _SaveButton(
                    enabled: _hasChanged && !isLoading,
                    isLoading: isLoading,
                    onPressed: _handleSave,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: ScreenSize.height * 0.016,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool enabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const _SaveButton({
    required this.enabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (enabled || isLoading) ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Container(
          width: double.infinity,
          height: ScreenSize.height * 0.068,
          decoration: BoxDecoration(
            gradient: (enabled || isLoading)
                ? const LinearGradient(
                    colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: (enabled || isLoading) ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.018),
            boxShadow: (enabled || isLoading)
                ? [
                    BoxShadow(
                      color: const Color(0xFF3D5AFE).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: ScreenSize.height * 0.028,
                    height: ScreenSize.height * 0.028,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    'Save Changes',
                    style: TextStyle(
                      color: (enabled || isLoading)
                          ? Colors.white
                          : Colors.grey.shade500,
                      fontSize: ScreenSize.height * 0.018,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
