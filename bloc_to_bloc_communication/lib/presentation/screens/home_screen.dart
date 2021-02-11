import 'package:bloc_to_bloc_communication/constants/enum.dart';
import 'package:bloc_to_bloc_communication/logic/cubit/counter_cubit.dart';
import 'package:bloc_to_bloc_communication/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.bloc<CounterCubit>().increament();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.bloc<CounterCubit>().decrement();

        }
      },
      child: Scaffold(
        key: homeScreenKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wifi',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.green),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.red),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.grey),
                    );
                  }

                  return CircularProgressIndicator();
                },
              ),
              Divider(
                height: 5,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    homeScreenKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    homeScreenKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'Negative No: ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 0) {
                    return Text(
                      '--->> ' + state.counterValue.toString() + ' <<---',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue != 0 &&
                      state.counterValue % 2 == 0) {
                    return Text(
                      'Positive Even ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 7) {
                    return Text(
                      'Birthday ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      'Positive Odd: ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
              ),
              // SizedBox(
              //   height: 24,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title}'),
              //       onPressed: () {
              //         BlocProvider.of<CounterCubit>(context).decrement();
              //       },
              //       tooltip: 'Decrement',
              //       child: Icon(Icons.remove),
              //     ),
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title} 2nd'),
              //       onPressed: () {
              //         // context.bloc<CounterCubit>().increament();
              //         BlocProvider.of<CounterCubit>(context).increament();
              //       },
              //       tooltip: 'Increment',
              //       child: Icon(Icons.add),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // MaterialButton(
              //   color: widget.color,
              //   onPressed: () {
              //     Navigator.of(context).pushNamed(
              //       '/second',
              //       arguments: homeScreenKey,
              //     );
              //   },
              //   child: Text('Go to Second Screen'),
              // )
            ],
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   child: Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
