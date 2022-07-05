import 'package:flutter/material.dart';
import 'package:flutter_bloc_poc/navigation/routes.dart';
import 'package:flutter_bloc_poc/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), nextPage);
    super.initState();
  }

  nextPage() {
    Navigator.pushReplacementNamed(context, Routes.homeScreen,
        arguments: HomeScreenArgs(title: "Flutter Bloc Demo :)"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "FLUTTER BLOC",
            )
          ],
        ),
      ),
    );
  }
}
