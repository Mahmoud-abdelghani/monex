import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';

class SectionErrorView extends StatelessWidget {
  final String message;

  const SectionErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return HomeSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.03,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: HomePalette.expense,
            size: ScreenSize.height * 0.04,
          ),
          SizedBox(height: ScreenSize.height * 0.01),
          Text(
            'This section could not be loaded',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0175,
              fontWeight: FontWeight.w700,
              color: HomePalette.textDark,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.005),
          Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenSize.height * 0.0145,
              color: HomePalette.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
