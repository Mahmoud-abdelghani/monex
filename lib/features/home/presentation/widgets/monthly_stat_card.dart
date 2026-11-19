import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/amount_formatter.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';

class MonthlyStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double amount;
  final int count;
  final Color color;

  const MonthlyStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconCircle = ScreenSize.height * 0.04;

    return HomeSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: iconCircle,
                height: iconCircle,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: ScreenSize.height * 0.022,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.025),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.0165,
                    fontWeight: FontWeight.w600,
                    color: HomePalette.textGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.016),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              AmountFormatter.money(amount),
              maxLines: 1,
              style: TextStyle(
                fontSize: ScreenSize.height * 0.0215,
                fontWeight: FontWeight.w800,
                color: HomePalette.textDark,
              ),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.004),
          Text(
            count == 1 ? '1 transaction' : '$count transactions',
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0138,
              color: HomePalette.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
