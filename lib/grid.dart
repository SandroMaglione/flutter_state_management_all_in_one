import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/constants.dart';

class Grid extends StatefulWidget {
  const Grid({
    super.key,
  });

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final pos = details.localPosition;
        final index = (pos / (Constants.gridDimension / Constants.gridSize));
        print('Pan: $pos | ${index.dx.floor()},${index.dy.floor()}');
      },
      child: GridView.count(
        crossAxisCount: Constants.gridSize,
        children: List.generate(
          Constants.gridSize * Constants.gridSize,
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
    );
  }
}
