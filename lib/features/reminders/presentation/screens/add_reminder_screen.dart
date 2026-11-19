import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/reminders/presentation/cubit/add_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/screens/reminders_list_screen.dart';
import 'package:monex/features/reminders/presentation/widgets/reminder_form_fields.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  static const String routeName = '/add-reminder';

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  late final ReminderFormController _ctrl;
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _ctrl = ReminderFormController();
    _ctrl.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onFormChanged);
    _ctrl.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    final valid = _ctrl.isValid;
    if (valid != _canSubmit) setState(() => _canSubmit = valid);
  }

  void _handleAdd() {
    if (!_ctrl.validate()) return;
    BlocProvider.of<AddReminderCubit>(context).addreminder(
      title: _ctrl.title,
      amount: _ctrl.amount!,
      frequency: _ctrl.frequency!,
      deadline: _ctrl.deadline!,
      scheduleDate: _ctrl.scheduleDate!,
    );
  }

  void _showErrorSnackbar(String message) {
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

    return BlocConsumer<AddReminderCubit, AddReminderState>(
      listener: (context, state) {
        if (state is AddReminderSuccess) {
          // الـ stream في WatchReminderCubit هيلاحق الـ reminder الجديد تلقائياً
          Navigator.pushNamedAndRemoveUntil(
            context,
            RemindersListScreen.routeName,
            (route) => false,
          );
        } else if (state is AddReminderFailure) {
          _showErrorSnackbar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AddReminderLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: isLoading ? null : () => Navigator.of(context).pop(),
              child: Container(
                margin: EdgeInsets.all(ScreenSize.height * 0.01),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isLoading
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                ),
                child: Icon(
                  Icons.chevron_left,
                  size: ScreenSize.height * 0.03,
                  color: isLoading
                      ? Colors.grey.shade300
                      : const Color(0xFF1A1A2E),
                ),
              ),
            ),
            title: Text(
              'Set Reminder',
              style: TextStyle(
                fontSize: ScreenSize.height * 0.024,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E),
              ),
            ),
          ),
          body: Column(
            children: [
              // ── Scrollable form ─────────────────────────────────────
              Expanded(
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.05,
                      vertical: ScreenSize.height * 0.02,
                    ),
                    child: ReminderFormFields(controller: _ctrl),
                  ),
                ),
              ),

              // ── Bottom action bar ────────────────────────────────────
              Container(
                padding: EdgeInsets.fromLTRB(
                  ScreenSize.width * 0.05,
                  ScreenSize.height * 0.015,
                  ScreenSize.width * 0.05,
                  ScreenSize.height * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: AnimatedOpacity(
                  opacity: _canSubmit || isLoading ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 200),
                  child: AuthButton(
                    label: 'ADD REMINDER',
                    isLoading: isLoading,
                    onPressed: (_canSubmit && !isLoading) ? _handleAdd : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
