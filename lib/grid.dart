import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/constants.dart';

typedef GridIndex = (int, int);

class Grid extends StatefulWidget {
  const Grid({
    super.key,
  });

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  final Set<GridIndex> _indexes = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _indexes.add(_panIndex(details.localPosition));
      },
      onPanUpdate: (details) {
        _indexes.add(_panIndex(details.localPosition));
      },
      onPanEnd: (details) {
        print(_indexes);
        _indexes.clear();
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
                "(${(index / Constants.gridSize).floor()}, ${index % Constants.gridSize})",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }

  GridIndex _panIndex(Offset localPosition) {
    final index =
        localPosition / (Constants.gridDimension / Constants.gridSize);
    return (index.dy.floor(), index.dx.floor());
  }
}
