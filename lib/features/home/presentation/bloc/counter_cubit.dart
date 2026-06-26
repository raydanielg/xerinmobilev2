import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

/// Sample cubit demonstrating state management with BLoC.
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(0));

  void increment() => emit(CounterState(state.value + 1));
  void decrement() => emit(CounterState(state.value - 1));
  void reset() => emit(const CounterState(0));
}
