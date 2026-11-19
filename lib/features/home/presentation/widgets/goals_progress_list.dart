import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/goal_progress.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/goal_progress_tile.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';

class GoalsProgressList extends StatefulWidget {
  final List<GoalProgress> items;
  final int collapsedCount;

  const GoalsProgressList({
    super.key,
    required this.items,
    this.collapsedCount = 3,
  });

  @override
  State<GoalsProgressList> createState() => _GoalsProgressListState();
}

class _GoalsProgressListState extends State<GoalsProgressList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasMore = widget.items.length > widget.collapsedCount;
    final visible = (_isExpanded || !hasMore)
        ? widget.items
        : widget.items.take(widget.collapsedCount).toList();

    return HomeSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.006,
      ),
      child: Column(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                for (var i = 0; i < visible.length; i++) ...[
                  if (i > 0) const Divider(height: 1, color: HomePalette.track),
                  GoalProgressTile(
                    key: ValueKey(visible[i].goal.id),
                    item: visible[i],
                  ),
                ],
              ],
            ),
          ),
          if (hasMore) ...[
            const Divider(height: 1, color: HomePalette.track),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.height * 0.014,
                  ),
                  child: Text(
                    _isExpanded
                        ? 'Show less'
                        : 'Show all ${widget.items.length} goals',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.0158,
                      fontWeight: FontWeight.w700,
                      color: HomePalette.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
