import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../bloc/counter_cubit.dart';

/// Sample home page with BLoC counter.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 8),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  label: 'Decrement',
                  onPressed: () => context.read<CounterCubit>().decrement(),
                  isSecondary: true,
                ),
                CustomButton(
                  label: 'Increment',
                  onPressed: () => context.read<CounterCubit>().increment(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: 'Reset',
              onPressed: () => context.read<CounterCubit>().reset(),
            ),
          ],
        ),
      ),
    );
  }
}
