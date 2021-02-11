import 'package:bloc_to_bloc_communication/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key, this.title, this.color, this.homeScreenKey})
      : super(key: key);

  final String title;
  final Color color;
  final GlobalKey<ScaffoldState> homeScreenKey;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  GlobalKey<ScaffoldState> secondScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: secondScreenKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  widget.homeScreenKey.currentState.removeCurrentSnackBar();
                  secondScreenKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  widget.homeScreenKey.currentState.removeCurrentSnackBar();
                  secondScreenKey.currentState.showSnackBar(
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
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    // context.bloc<CounterCubit>().increament();
                    BlocProvider.of<CounterCubit>(context).increament();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            // SizedBox(
            //   height: 24,
            // ),
            // MaterialButton(
            //   color: widget.color,
            //   onPressed: () {},
            //   child: Text('Go to Second SCreen'),
            // )
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
