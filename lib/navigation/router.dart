import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_poc/blocs/bloc/counter_bloc.dart';
import 'package:flutter_bloc_poc/navigation/routes.dart';
import 'package:flutter_bloc_poc/screens/home_screen.dart';
import 'package:flutter_bloc_poc/screens/spash_screen.dart';

class Router {
  static Route? onGenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;
    Object? args = settings.arguments;

    switch (routeName) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CounterBloc(),
                  child: const MyHomePage(title: "Bloc Demo"),
                ),
            settings: settings);
      default:
        return null;
    }
  }
}