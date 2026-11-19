import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/amount_formatter.dart';
import 'package:monex/features/home/presentation/utils/goal_progress.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class GoalProgressTile extends StatelessWidget {
  final GoalProgress item;

  const GoalProgressTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final accent = item.isCompleted ? HomePalette.income : HomePalette.primary;
    final iconBox = ScreenSize.height * 0.05;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.014),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconBox,
            height: iconBox,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(ScreenSize.height * 0.014),
            ),
            child: Icon(
              item.isCompleted ? Icons.check_rounded : Icons.flag_rounded,
              color: accent,
              size: ScreenSize.height * 0.026,
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.goal.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.0185,
                          fontWeight: FontWeight.w700,
                          color: HomePalette.textDark,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenSize.width * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.024,
                        vertical: ScreenSize.height * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(ScreenSize.height * 0.02),
                      ),
                      child: Text(
                        '${item.percent}%',
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.0142,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height * 0.01),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: item.progress),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(ScreenSize.height),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: ScreenSize.height * 0.009,
                        backgroundColor: HomePalette.track,
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    );
                  },
                ),
                SizedBox(height: ScreenSize.height * 0.008),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AmountFormatter.money(item.savedAmount),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.0145,
                          fontWeight: FontWeight.w600,
                          color: HomePalette.textDark,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenSize.width * 0.02),
                    Flexible(
                      child: Text(
                        AmountFormatter.money(item.goal.targetAmount),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.0145,
                          color: HomePalette.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height * 0.008),
                Text(
                  item.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.0138,
                    height: 1.35,
                    color: item.isCompleted
                        ? HomePalette.income
                        : HomePalette.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
