import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/constants.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid.dart';

final dictionary = Dictionary();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dictionary.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Column(
        children: [
          Container(
            height: Constants.gridDimension,
            width: Constants.gridDimension,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: const Grid(),
          ),
        ],
      ),
    );
  }
}
