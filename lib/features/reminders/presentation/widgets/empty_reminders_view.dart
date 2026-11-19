import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

class EmptyRemindersView extends StatelessWidget {
  final VoidCallback onAddReminder;

  const EmptyRemindersView({super.key, required this.onAddReminder});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: ScreenSize.height * 0.18,
              height: ScreenSize.height * 0.18,
              decoration: BoxDecoration(
                color: const Color(0xFF3D5AFE).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                size: ScreenSize.height * 0.08,
                color: const Color(0xFF3D5AFE),
              ),
            ),

            SizedBox(height: ScreenSize.height * 0.03),

            Text(
              'No reminders yet',
              style: TextStyle(
                fontSize: ScreenSize.height * 0.024,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E),
              ),
            ),

            SizedBox(height: ScreenSize.height * 0.01),

            Text(
              'Add a reminder to stay on top of\nyour upcoming payments.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenSize.height * 0.016,
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            SizedBox(height: ScreenSize.height * 0.035),

            GestureDetector(
              onTap: onAddReminder,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.08,
                  vertical: ScreenSize.height * 0.016,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(ScreenSize.height * 0.016),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3D5AFE).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Add Reminder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSize.height * 0.017,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}