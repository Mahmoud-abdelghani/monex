import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/core/enums/contribution_period.dart';

class FrequencySelectorSheet extends StatelessWidget {
  final ContributionPeriod? selected;
  final ValueChanged<ContributionPeriod> onSelected;

  const FrequencySelectorSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required ContributionPeriod? selected,
    required ValueChanged<ContributionPeriod> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FrequencySelectorSheet(
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }

  static String labelFor(ContributionPeriod period) {
    switch (period) {
      case ContributionPeriod.none:
        return 'One-time';
      case ContributionPeriod.daily:
        return 'Daily';
      case ContributionPeriod.weekly:
        return 'Weekly';
      case ContributionPeriod.monthly:
        return 'Monthly';
      case ContributionPeriod.yearly:
        return 'Yearly';
    }
  }

  static IconData iconFor(ContributionPeriod period) {
    switch (period) {
      case ContributionPeriod.none:
        return Icons.looks_one_outlined;
      case ContributionPeriod.daily:
        return Icons.today_outlined;
      case ContributionPeriod.weekly:
        return Icons.view_week_outlined;
      case ContributionPeriod.monthly:
        return Icons.calendar_month_outlined;
      case ContributionPeriod.yearly:
        return Icons.event_repeat_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenSize.height * 0.025),
        ),
      ),
      padding: EdgeInsets.only(
        top: ScreenSize.height * 0.02,
        bottom: ScreenSize.height * 0.03 +
            MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: ScreenSize.width * 0.1,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(height: ScreenSize.height * 0.02),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
            child: Row(
              children: [
                Text(
                  'Select Frequency',
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.022,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ScreenSize.height * 0.008),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
            child: Text(
              '"One-time" sends a single notification on the schedule date.',
              style: TextStyle(
                fontSize: ScreenSize.height * 0.014,
                color: Colors.grey,
              ),
            ),
          ),

          SizedBox(height: ScreenSize.height * 0.015),

          ...ContributionPeriod.values.map((period) {
            final isSelected = period == selected;
            return _FrequencyTile(
              period: period,
              isSelected: isSelected,
              onTap: () {
                Navigator.of(context).pop();
                onSelected(period);
              },
            );
          }),
        ],
      ),
    );
  }
}

class _FrequencyTile extends StatelessWidget {
  final ContributionPeriod period;
  final bool isSelected;
  final VoidCallback onTap;

  const _FrequencyTile({
    required this.period,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.016,
        ),
        child: Row(
          children: [
            Container(
              width: ScreenSize.height * 0.045,
              height: ScreenSize.height * 0.045,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3D5AFE).withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(ScreenSize.height * 0.012),
              ),
              child: Icon(
                FrequencySelectorSheet.iconFor(period),
                color: isSelected
                    ? const Color(0xFF3D5AFE)
                    : Colors.grey.shade500,
                size: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.035),
            Text(
              FrequencySelectorSheet.labelFor(period),
              style: TextStyle(
                fontSize: ScreenSize.height * 0.018,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF3D5AFE)
                    : const Color(0xFF1A1A2E),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF3D5AFE),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
