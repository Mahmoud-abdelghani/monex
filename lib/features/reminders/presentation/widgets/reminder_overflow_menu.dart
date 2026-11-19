import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

class ReminderOverflowMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onReschedule;

  const ReminderOverflowMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuAction>(
      onSelected: (action) {
        switch (action) {
          case _MenuAction.edit:
            onEdit();
          case _MenuAction.delete:
            onDelete();
          case _MenuAction.reschedule:
            onReschedule();
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.016),
      ),
      elevation: 4,
      color: Colors.white,
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_horiz,
        color: Colors.grey.shade500,
        size: ScreenSize.height * 0.024,
      ),
      itemBuilder: (_) => [
        _buildItem(
          value: _MenuAction.edit,
          icon: Icons.edit_outlined,
          label: 'Edit',
          color: const Color(0xFF1A1A2E),
        ),
        _buildItem(
          value: _MenuAction.reschedule,
          icon: Icons.notifications_active_outlined,
          label: 'Reschedule Notifications',
          color: const Color(0xFF3D5AFE),
        ),
        _buildItem(
          value: _MenuAction.delete,
          icon: Icons.delete_outline,
          label: 'Delete',
          color: Colors.redAccent,
        ),
      ],
    );
  }

  PopupMenuItem<_MenuAction> _buildItem({
    required _MenuAction value,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

enum _MenuAction { edit, delete, reschedule }