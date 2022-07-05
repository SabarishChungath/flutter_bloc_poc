import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_poc/blocs/bloc/counter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    log("build () => called");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Selector is called when there is a change in bloc state variable.
            BlocSelector<CounterBloc, CounterState, int>(
              selector: (state) {
                return state.count;
              },
              builder: (_, count) {
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            )
            // builder is called when there is a change in bloc state.
            // BlocBuilder<CounterBloc, CounterState>(
            //   builder: (context, state) {
            //     log("blocBuilder () => called");
            //     return Text(
            //       state.count.toString(),
            //       style: Theme.of(context).textTheme.headline4,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(IncrementCounter());
            },
            tooltip: 'Increment',
            heroTag: 'Increment',
            backgroundColor: Colors.greenAccent,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounter());
            },
            tooltip: 'Decrement',
            heroTag: 'Decrement',
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(ResetCounter());
            },
            tooltip: 'Reset',
            heroTag: 'Reset',
            child: const Icon(Icons.restart_alt_rounded),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeScreenArgs {
  String title;
  HomeScreenArgs({required this.title});
}
