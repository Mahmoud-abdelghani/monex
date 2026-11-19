import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/widgets/budget_card.dart';
import 'package:monex/features/home/presentation/widgets/goals_overview_section.dart';
import 'package:monex/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:monex/features/home/presentation/widgets/home_header.dart';
import 'package:monex/features/home/presentation/widgets/monthly_overview_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: HomePalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            ScreenSize.width * 0.05,
            ScreenSize.height * 0.02,
            ScreenSize.width * 0.05,
            ScreenSize.height * 0.03,
          ),
          child: Column(
            children: [
              const HomeHeader(),
              SizedBox(height: ScreenSize.height * 0.022),
              const BudgetCard(),
              SizedBox(height: ScreenSize.height * 0.03),
              const MonthlyOverviewSection(),
              SizedBox(height: ScreenSize.height * 0.03),
              const GoalsOverviewSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Navigation will be connected later.
        },
      ),
    );
  }
}
