import 'package:flutter/cupertino.dart';

class DeleteReminderDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final bool isLoading;

  const DeleteReminderDialog({
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
      builder: (_) => DeleteReminderDialog(
        onConfirm: onConfirm,
        isLoading: isLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Delete reminder?'),
      content: const Padding(
        padding: EdgeInsets.only(top: 6),
        child: Text(
          'Are you sure you want to delete this reminder? Its scheduled '
          'notifications will also be cancelled, so you won\'t receive any '
          'more notifications for it.',
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: isLoading ? null : onConfirm,
          child: isLoading
              ? const CupertinoActivityIndicator()
              : const Text('Delete Reminder'),
        ),
      ],
    );
  }
}