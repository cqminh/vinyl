import 'package:bloc/bloc.dart';

import 'package:vinyl/counter/bloc/counter_event.dart';
import 'package:vinyl/counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncremented>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<CounterDecremented>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });

    on<CounterReset>((event, emit) {
      emit(CounterState(count: 0));
    });
  }
}