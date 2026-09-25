import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl/counter/bloc/counter_bloc.dart';
import 'package:vinyl/counter/bloc/counter_event.dart';
import 'package:vinyl/counter/bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: MyHomePage(title: 'Demo App',),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) => Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'dec',
            onPressed: () => context.read<CounterBloc>().add(CounterDecremented()),
            tooltip: 'Decremented',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () => context.read<CounterBloc>().add(CounterReset()),
            tooltip: 'Reset',
            child: const Icon(Icons.exposure_zero),
          ),
          FloatingActionButton(
            heroTag: 'inc',
            onPressed: () => context.read<CounterBloc>().add(CounterIncremented()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
