import 'package:flutter/material.dart';

const gridSize = 4;

void main() {
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
            height: 600,
            width: 600,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: GridView.count(
              crossAxisCount: gridSize,
              children: List.generate(
                gridSize * gridSize,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
