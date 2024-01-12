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
        setState(() {
          _indexes.add(_panIndex(details.localPosition));
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _indexes.add(_panIndex(details.localPosition));
        });
      },
      onPanEnd: (details) {
        print(_indexes);
        setState(() {
          _indexes.clear();
        });
      },
      child: GridView.count(
        crossAxisCount: Constants.gridSize,
        children: List.generate(
          Constants.gridSize * Constants.gridSize,
          (index) {
            final row = (index / Constants.gridSize).floor();
            final column = index % Constants.gridSize;
            return Container(
              decoration: BoxDecoration(
                color: _indexes.contains((row, column))
                    ? Colors.cyan
                    : Colors.cyan[50],
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  "($row, $column)",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            );
          },
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
