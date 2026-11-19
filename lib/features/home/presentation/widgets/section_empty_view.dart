import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';

class SectionEmptyView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const SectionEmptyView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final circle = ScreenSize.height * 0.07;

    return HomeSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.03,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: circle,
            height: circle,
            decoration: BoxDecoration(
              color: HomePalette.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: HomePalette.primary,
              size: ScreenSize.height * 0.032,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.015),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0185,
              fontWeight: FontWeight.w700,
              color: HomePalette.textDark,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.006),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0148,
              height: 1.45,
              color: HomePalette.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
