import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'router.dart';

void main(List<String> args) {
  print('Received entrypointArgs: $args');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    _setupNavigationChannel();
  }

  void _setupNavigationChannel() {
    _channel = const MethodChannel('com.kosukesaigusa.iOSApp/navigation');
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'navigateTo') {
      final route = call.arguments as String;
      final pageRoute =
          appRouter.buildPageRoute(route, includePrefixMatches: false);
      if (pageRoute != null) {
        appRouter.pushAndPopUntil(pageRoute, predicate: (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
    );
  }
}

@RoutePage()
class AddToAppHomePage extends StatelessWidget {
  const AddToAppHomePage({super.key});

  static const path = '/addToAppHome';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Add To App Home Page'),
      ),
    );
  }
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('This is the Home screen'),
      ),
    );
  }
}

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const path = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('This is the Profile screen'),
      ),
    );
  }
}

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const path = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('This is the Settings screen'),
      ),
    );
  }
}
