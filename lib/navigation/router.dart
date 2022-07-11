import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_poc/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_bloc_poc/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_bloc_poc/navigation/router_utils.dart';
import 'package:flutter_bloc_poc/navigation/routes.dart';
import 'package:flutter_bloc_poc/screens/home_screen.dart';
import 'package:flutter_bloc_poc/screens/spash_screen.dart';
import 'package:flutter_bloc_poc/screens/weather_screen.dart';

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
        if (hasInvalidArgs<HomeScreenArgs>(args)) {
          return misTypedArgsRoute<HomeScreenArgs>(args);
        }
        final typedArgs = args as HomeScreenArgs;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CounterBloc(),
                  child: MyHomePage(title: typedArgs.title),
                ),
            settings: settings);
      case Routes.weatherScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(),
            child: const WeatherScreen(),
          ),
        );
      default:
        return unknownPageRoute(settings.name ?? "");
    }
  }
}
