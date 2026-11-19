import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/presentation/cubit/delete_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/reschedule_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/watch_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/screens/add_reminder_screen.dart';
import 'package:monex/features/reminders/presentation/widgets/delete_reminder_dialog.dart';
import 'package:monex/features/reminders/presentation/widgets/edit_reminder_bottom_sheet.dart';
import 'package:monex/features/reminders/presentation/widgets/empty_reminders_view.dart';
import 'package:monex/features/reminders/presentation/widgets/reminder_card.dart';
import 'package:monex/features/reminders/presentation/widgets/reschedule_reminder_dialog.dart';

class RemindersListScreen extends StatefulWidget {
  const RemindersListScreen({super.key});

  static const String routeName = '/reminders';

  @override
  State<RemindersListScreen> createState() => _RemindersListScreenState();
}

class _RemindersListScreenState extends State<RemindersListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WatchReminderCubit>().watchReminders();
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

    return MultiBlocListener(
      listeners: [
        // Watch failures
        BlocListener<WatchReminderCubit, WatchReminderState>(
          listener: (_, state) {
            if (state is WatchReminderFailure) {
              _showErrorSnackbar(state.message);
            }
          },
        ),

        // Delete
        BlocListener<DeleteReminderCubit, DeleteReminderState>(
          listener: (_, state) {
            if (state is DeleteReminderSuccess) {
              Navigator.of(context).pop();
            } else if (state is DeleteReminderFailure) {
              Navigator.of(context).pop();
              _showErrorSnackbar(state.message);
            }
          },
        ),

        // Reschedule
        BlocListener<RescheduleReminderCubit, RescheduleReminderState>(
          listener: (_, state) {
            if (state is RescheduleReminderSuccess) {
              Navigator.of(context).pop();
            } else if (state is RescheduleReminderFailure) {
              Navigator.of(context).pop();
              _showErrorSnackbar(state.message);
            }
          },
        ),
      ],
      child: BlocBuilder<WatchReminderCubit, WatchReminderState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8FC),
            appBar: _buildAppBar(context),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: EdgeInsets.all(ScreenSize.height * 0.01),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            Icons.chevron_left,
            size: ScreenSize.height * 0.03,
            color: const Color(0xFF1A1A2E),
          ),
        ),
      ),
      title: Text(
        'Reminders',
        style: TextStyle(
          fontSize: ScreenSize.height * 0.024,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1A1A2E),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, AddReminderScreen.routeName),
          child: Container(
            margin: EdgeInsets.only(right: ScreenSize.width * 0.04),
            width: ScreenSize.height * 0.042,
            height: ScreenSize.height * 0.042,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: ScreenSize.height * 0.025,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(WatchReminderState state) {
    if (state is WatchReminderInitial || state is WatchReminderLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF3D5AFE),
          strokeWidth: 2.5,
        ),
      );
    }

    if (state is WatchReminderSuccess) {
      if (state.reminders.isEmpty) {
        return EmptyRemindersView(
          onAddReminder: () =>
              Navigator.pushNamed(context, AddReminderScreen.routeName),
        );
      }
      return _RemindersList(reminders: state.reminders);
    }

    return EmptyRemindersView(
      onAddReminder: () =>
          Navigator.pushNamed(context, AddReminderScreen.routeName),
    );
  }
}

class _RemindersList extends StatelessWidget {
  final List<ReminderEntity> reminders;

  const _RemindersList({required this.reminders});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteReminderCubit, DeleteReminderState>(
      builder: (context, deleteState) {
        return BlocBuilder<RescheduleReminderCubit, RescheduleReminderState>(
          builder: (context, rescheduleState) {
            final isDeleting = deleteState is DeleteReminderLoading;
            final isRescheduling = rescheduleState is RescheduleReminderLoading;

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.015,
              ),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return ReminderCard(
                  reminder: reminder,

                  onEdit: () =>
                      EditReminderBottomSheet.show(context, reminder: reminder),

                  onDelete: () => DeleteReminderDialog.show(
                    context,
                    isLoading: isDeleting,
                    onConfirm: () => context
                        .read<DeleteReminderCubit>()
                        .deletereminder(reminder.id),
                  ),

                  onReschedule: () => RescheduleReminderDialog.show(
                    context,
                    isLoading: isRescheduling,
                    onConfirm: () => context
                        .read<RescheduleReminderCubit>()
                        .reschedule(reminder.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
