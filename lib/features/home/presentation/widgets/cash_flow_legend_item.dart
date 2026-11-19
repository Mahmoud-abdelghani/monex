import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class CashFlowLegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const CashFlowLegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final dot = ScreenSize.height * 0.011;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dot,
          height: dot,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: ScreenSize.width * 0.015),
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenSize.height * 0.0142,
            fontWeight: FontWeight.w600,
            color: HomePalette.textGrey,
          ),
        ),
      ],
    );
  }
}
