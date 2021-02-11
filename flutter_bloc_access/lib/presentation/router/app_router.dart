import 'package:flutter/material.dart';
import 'package:flutter_bloc_access/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_access/presentation/screens/second_screen.dart';

class AppRouter{
  Route onGenerateRoute(RouteSettings settings){
    final GlobalKey<ScaffoldState> key = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
              title: "Home Screen",
              color:  Colors.blueAccent,
            ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color:  Colors.blueAccent,
            homeScreenKey: key,
          ),
        );
      default:
        return null;

    }
  }
}