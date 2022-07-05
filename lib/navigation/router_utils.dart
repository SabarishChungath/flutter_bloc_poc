import 'package:flutter/material.dart';

// Navigates to this route if not mentioned in router (Default Route / Error Route)
PageRoute unknownPageRoute(String routeName) => MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Container(
          color: Colors.redAccent,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  "RouteName: $routeName not found!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
              )
            ],
          ),
        ),
      ),
    );

PageRoute misTypedArgsRoute<T>(Object? args) => MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Container(
          color: Colors.redAccent,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Arguments Mistype!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Expected ${T.toString()} but found ${args.runtimeType}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
              )
            ],
          ),
        ),
      ),
    );

bool hasInvalidArgs<T>(Object? args) => args != null && args is! T;
