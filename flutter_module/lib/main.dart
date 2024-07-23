import 'package:flutter/material.dart';

void main(List<String> args) {
  print('Received entrypointArgs: $args');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello World!'),
              Text(
                String.fromEnvironment(
                  'FOO',
                  defaultValue: "String.fromEnvironment('Foo') is not defined",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
