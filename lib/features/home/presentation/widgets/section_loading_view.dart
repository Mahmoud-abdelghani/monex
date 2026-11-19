import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';

class SectionLoadingView extends StatelessWidget {
  const SectionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeSurfaceCard(
      child: SizedBox(
        height: ScreenSize.height * 0.14,
        child: const Center(
          child: CircularProgressIndicator(
            color: HomePalette.primary,
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}
