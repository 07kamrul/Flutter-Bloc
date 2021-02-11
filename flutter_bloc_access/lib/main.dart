import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_access/presentation/router/app_router.dart';
import 'logic/cubit/counter_cubit.dart';

void main() {
  //testing
/*
  final CounterState counterState1 = CounterState(counterValue: 1);
  final CounterState counterState2 = CounterState(counterValue: 1);
  print(counterState1 == counterState2);
*/


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final CounterCubit _counterCubit = CounterCubit();

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Bloc Pattern',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        // home: BlocProvider<CounterCubit>(
        //   create: (context) => CounterCubit(),
        //   child: HomeScreen(
        //     title: 'Bloc Pattern Home Page',
        //     color: Colors.blueAccent,
        //   ),
        // )

        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  // @override
  // void dispose() {
  //   _counterCubit.close();
  //   super.dispose();
  // }
}
