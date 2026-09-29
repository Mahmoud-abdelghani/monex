import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/usecase/sync_usecase.dart';
import 'package:monex/features/budget/presentation/cubit/create_budget_cubit.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});
  static const String routeName = '/create-budget';

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBudgetCubit, CreateBudgetState>(
      listener: (context, state) {
        if (state is CreateBudgetSuccess) {
          getIt<SyncUsecase>().call();
          Navigator.pushNamed(context, HomeScreen.routeName);
        } else if (state is CreateBudgetFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: TextButton(
              child: const Text('Create Budget'),
              onPressed: () {
                BlocProvider.of<CreateBudgetCubit>(
                  context,
                ).createBudget(balance: 5000);
              },
            ),
          ),
        );
      },
    );
  }
}
