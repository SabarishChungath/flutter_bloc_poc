part of 'counter_bloc.dart';

class CounterState {
  final int count;
  CounterState({required this.count});
}

class InitialCounter extends CounterState {
  InitialCounter() : super(count: 0);
}
