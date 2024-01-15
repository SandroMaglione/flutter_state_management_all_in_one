import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/signals/grid.dart';

// ignore: missing_provider_scope
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Signals State Management',
      home: Scaffold(
        body: Grid(),
      ),
    );
  }
}
