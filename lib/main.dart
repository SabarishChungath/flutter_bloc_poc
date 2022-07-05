import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc_poc/navigation/router.dart';
import 'package:flutter_bloc_poc/navigation/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Bloc Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: Router.onGenerateRoute);
  }
}
