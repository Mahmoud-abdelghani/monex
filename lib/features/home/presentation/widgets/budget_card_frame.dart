import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class BudgetCardFrame extends StatelessWidget {
  final Widget child;

  const BudgetCardFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final iconCircle = ScreenSize.height * 0.042;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.055,
        vertical: ScreenSize.height * 0.024,
      ),
      decoration: BoxDecoration(
        gradient: HomePalette.primaryGradient,
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.028),
        boxShadow: [
          BoxShadow(
            color: HomePalette.primary.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: iconCircle,
                height: iconCircle,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: ScreenSize.height * 0.022,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Text(
                'Available Budget',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.0165,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          child,
        ],
      ),
    );
  }
}
