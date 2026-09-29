import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:monex/features/budget/presentation/cubit/watch_budget_cubit.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';
import 'package:monex/features/expense/presentation/cubit/delete_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/update_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/watch_expenses_cubit.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/presentation/cubit/add_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/complete_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/delete_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/update_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/watch_goal_cubit.dart';
import 'package:monex/features/income/presentation/cubit/add_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/delete_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/update_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/watch_incomes_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/add_saving_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/watch_savings_cubit.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: ScreenSize.height * 0.1),

                SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height * 0.3,
                  child: BlocBuilder<WatchBudgetCubit, WatchBudgetState>(
                    builder: (context, state) {
                      if (state is WatchBudgetLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WatchBudgetFailure) {
                        return Center(child: Text(state.message));
                      } else if (state is WatchBudgetSuccess) {
                        final budget = state.budget;
                        return Center(
                          child: Text('Budget: ${budget!.balance} EGP'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      // SyncEngineImpl(
                      //   expenseLocalDataSource: getIt<ExpenseLocalDataSource>(),
                      //   expenseRemoteDataSource: getIt<ExpenseRemoteDataSource>(),
                      //   pendingOperationsLocalDataSource:
                      //       getIt<PendingOperationsLocalDataSource>(),
                      // ).sync();
                      log('Adding expense');
                      getIt<ExpenseRepository>().addExpense(
                        expense: ExpenseEntity(
                          id: Uuid().v4(),
                          title: 'test لآ',
                          userId: '1',
                          amount: 200.0,
                          categoryId: '0e9fb798-fc7a-422c-a602-7d8ec07b8248',
                          date: DateTime.now(),
                          method: 'test',
                        ),
                      );
                    },
                    child: Text('Add Expense'),
                  ),
                ),

                Center(
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<LogoutCubit>(context).logout();
                    },
                    child: Text('Log Out'),
                  ),
                ),

                SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height * 0.3,
                  child: BlocBuilder<WatchExpensesCubit, WatchExpensesState>(
                    builder: (context, state) {
                      if (state is WatchExpensesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WatchExpensesFailure) {
                        return Center(child: Text(state.message));
                      } else if (state is WatchExpensesSuccess) {
                        final expenses = state.expenses;
                        return ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return ListTile(
                              title: Text(expense.title),
                              subtitle: Text('Amount: ${expense.amount}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<UpdateExpenseCubit>(
                                        context,
                                      ).updateExpense(
                                        ExpenseEntity(
                                          id: expense.id,
                                          title: expense.title,
                                          userId: expense.userId,
                                          amount: 500.0,
                                          categoryId: expense.categoryId,
                                          date: expense.date,
                                          method: expense.method,
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<DeleteExpenseCubit>(
                                        context,
                                      ).deleteExpense(expense.id);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      // SyncEngineImpl(
                      //   expenseLocalDataSource: getIt<ExpenseLocalDataSource>(),
                      //   expenseRemoteDataSource: getIt<ExpenseRemoteDataSource>(),
                      //   pendingOperationsLocalDataSource:
                      //       getIt<PendingOperationsLocalDataSource>(),
                      //   incomesLocalDataSource: getIt<IncomesLocalDataSource>(),
                      //   incomeRemoteDataSource: getIt<IncomesRemoteDataSource>(),
                      // ).sync();
                      log('Adding Income');
                      BlocProvider.of<AddIncomeCubit>(context).addIncome(
                        title: 'Test Income',
                        method: 'Visa',
                        amount: 1000.0,
                        userId: '1',
                        categoryId: '2210cb07-4134-4633-b7ac-98861339b7b2',
                        date: DateTime.now(),
                      );
                    },
                    child: Text('Add Income'),
                  ),
                ),
                SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height * 0.3,
                  child: BlocBuilder<WatchIncomesCubit, WatchIncomesState>(
                    builder: (context, state) {
                      if (state is WatchIncomesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WatchIncomesFailure) {
                        return Center(child: Text(state.message));
                      } else if (state is WatchIncomesSuccess) {
                        final incomes = state.incomes;
                        return ListView.builder(
                          itemCount: incomes.length,
                          itemBuilder: (context, index) {
                            final income = incomes[index];
                            return ListTile(
                              title: Text(income.title),
                              subtitle: Text('Amount: ${income.amount}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<UpdateIncomeCubit>(
                                        context,
                                      ).updateIncome(
                                        title: 'test i',
                                        id: income.id,
                                        method: 'Visa',
                                        amount: 200.5,
                                        userId: income.userId,
                                        categoryId: income.categoryId,
                                        date: income.date,
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<DeleteIncomeCubit>(
                                        context,
                                      ).deleteIncome(income.id);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      // SyncEngineImpl(
                      //   expenseLocalDataSource: getIt<ExpenseLocalDataSource>(),
                      //   expenseRemoteDataSource: getIt<ExpenseRemoteDataSource>(),
                      //   pendingOperationsLocalDataSource:
                      //       getIt<PendingOperationsLocalDataSource>(),
                      //   incomesLocalDataSource: getIt<IncomesLocalDataSource>(),
                      //   incomeRemoteDataSource: getIt<IncomesRemoteDataSource>(),
                      // ).sync();
                      log('Adding Goal');
                      BlocProvider.of<AddGoalCubit>(context).addGoal(
                        title: 'Goal Test',
                        targetAmount: 50.5,
                        deadline: DateTime(2028),
                        status: GoalStatus.active,
                        contributionPeriod: ContributionPeriod.monthly,
                      );
                    },
                    child: Text('Add Goal'),
                  ),
                ),
                SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height * 0.3,
                  child: BlocBuilder<WatchSavingsCubit, WatchSavingsState>(
                    builder: (context, state) {
                      if (state is WatchSavingsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WatchSavingsFailure) {
                        return Center(child: Text(state.message));
                      } else if (state is WatchSavingsSuccess) {
                        final savings = state.savings;
                        log('SS');
                        return BlocBuilder<WatchGoalCubit, WatchGoalState>(
                          builder: (context, state) {
                            if (state is WatchGoalLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is WatchGoalFailure) {
                              return Center(child: Text(state.message));
                            } else if (state is WatchGoalSuccess) {
                              final goals = state.goals;
                              return ListView.builder(
                                itemCount: goals.length,
                                itemBuilder: (context, index) {
                                  final income = goals[index];
                                  return ListTile(
                                    title: Text(income.title),
                                    subtitle: Text(
                                      'Amount: ${income.targetAmount} | ${savings.where((element) => element.goalId == goals[index].id).length} Savings',
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<UpdateGoalCubit>(
                                              context,
                                            ).updateGoal(
                                              title: 'Updated goal',
                                              targetAmount: 200000,
                                              deadline: DateTime(2030),
                                              status: GoalStatus.active,
                                              contributionPeriod:
                                                  ContributionPeriod.weekly,
                                              goalId: goals[index].id,
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<DeleteGoalCubit>(
                                              context,
                                            ).deleteGoal(goals[index].id);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<CompleteGoalCubit>(
                                              context,
                                            ).completeGoal(goals[index].id);
                                          },
                                          icon: Icon(Icons.done),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<AddSavingCubit>(
                                              context,
                                            ).addSaving(
                                              goalId: goals[index].id,
                                              amount: 20,
                                              date: DateTime.now(),
                                            );
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
