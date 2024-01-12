import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/constants.dart';

typedef GridIndex = (int, int);
typedef GridMargin = (double, double);

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
          final pos = _panIndex(details.localPosition);
          _indexes.add(pos.index);
        });
      },
      onPanUpdate: (details) {
        setState(() {
          final pos = _panIndex(details.localPosition);
          if (pos.margin.$1 > Constants.panMargin &&
              pos.margin.$1 < (1 - Constants.panMargin) &&
              pos.margin.$2 > Constants.panMargin &&
              pos.margin.$2 < (1 - Constants.panMargin)) {
            _indexes.add(pos.index);
          }
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

  ({GridIndex index, GridMargin margin}) _panIndex(Offset localPosition) {
    final offset =
        localPosition / (Constants.gridDimension / Constants.gridSize);
    final index = (offset.dy.floor(), offset.dx.floor());
    final margin = (offset.dy - index.$1, offset.dx - index.$2);
    return (index: index, margin: margin);
  }
}
