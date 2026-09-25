import 'package:bloc_test/bloc_test.dart';

import 'package:vinyl/counter/bloc/counter_bloc.dart';
import 'package:vinyl/counter/bloc/counter_event.dart';
import 'package:vinyl/counter/bloc/counter_state.dart';

void main() {
  blocTest<CounterBloc, CounterState>(
    'test bấm nút tăng 1 2 lần',
    build: () => CounterBloc(),
    act: (bloc) {
      bloc.add(CounterIncremented());
      bloc.add(CounterIncremented());
    },
    expect: () => [ CounterState(count: 1), CounterState(count: 2) ]
  );

  blocTest<CounterBloc, CounterState>(
    'test bấm nút reset',
    seed: () => const CounterState(count: 5),
    build: () => CounterBloc(),
    act: (bloc) => bloc.add(CounterReset()),
    expect: () => [ CounterState(count: 0) ]
  );

  blocTest<CounterBloc, CounterState>(
    'test bấm nút tăng 1',
    build: () => CounterBloc(),
    act: (bloc) => bloc.add(CounterIncremented()),
    expect: () => [ CounterState(count: 1) ]
  );


}