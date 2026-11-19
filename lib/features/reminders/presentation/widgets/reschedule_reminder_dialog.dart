import 'package:flutter/cupertino.dart';

class RescheduleReminderDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final bool isLoading;

  const RescheduleReminderDialog({
    super.key,
    required this.onConfirm,
    this.isLoading = false,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirm,
    bool isLoading = false,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (_) =>
          RescheduleReminderDialog(onConfirm: onConfirm, isLoading: isLoading),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Reschedule notifications?'),
      content: const Padding(
        padding: EdgeInsets.only(top: 6),
        child: Text(
          "We'll recreate the scheduled notifications for this reminder using "
          'its current schedule. Existing notifications may be replaced.',
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: isLoading ? null : onConfirm,
          child: isLoading
              ? const CupertinoActivityIndicator()
              : const Text(
                  'Reschedule',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
        ),
      ],
    );
  }
}
