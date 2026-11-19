import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE', 'en_US').format(now).toUpperCase(),
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0135,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: HomePalette.textGrey,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.003),
          Text(
            DateFormat('d MMM yyyy', 'en_US').format(now),
            style: TextStyle(
              fontSize: ScreenSize.height * 0.032,
              fontWeight: FontWeight.w800,
              color: HomePalette.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
