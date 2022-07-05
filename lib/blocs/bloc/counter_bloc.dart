import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialCounter()) {
    on<IncrementCounter>((event, emit) {
      final currentState = state.count;
      final incremented = currentState + 1;

      return emit(CounterState(count: incremented));
    });

    on<DecrementCounter>((event, emit) {
      final currentState = state.count;
      final incremented = currentState - 1;

      return emit(CounterState(count: incremented));
    });

    on<ResetCounter>((event, emit) {
      return emit(CounterState(count: 0));
    });
  }
}
