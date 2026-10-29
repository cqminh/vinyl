import 'package:flutter/material.dart';
import 'package:vinyl/core/config/app_config.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.config
  });

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vinyl',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Center(child: Text('Vinyl - ${config.flavor.name}')),
      ),
    );
  }
}