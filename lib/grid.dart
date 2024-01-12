import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/constants.dart';
import 'package:flutter_state_management_all_in_one/main.dart';

typedef GridIndex = (int, int);
typedef GridMargin = (double, double);
typedef GridCell = ({Letter letter, GridIndex index});

List<GridCell> extractGrid() {
  var extractList = [...Constants.letters];

  List<GridCell> cells = [];
  for (var i = 0; i < Constants.gridSize * Constants.gridSize; ++i) {
    final letter = extractList.removeAt(Random().nextInt(extractList.length));
    final index = ((i / Constants.gridSize).floor(), i % Constants.gridSize);

    cells.add((index: index, letter: letter));
  }

  return cells;
}

class Grid extends StatefulWidget {
  const Grid({
    super.key,
  });

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  final Set<GridIndex> _indexes = {};
  final List<({Letter letter, GridIndex index})> _letters = extractGrid();

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
        final word = _indexes
            .map(
              (index) => _letters.firstWhere(
                (cell) => cell.index == index,
              ),
            )
            .map(
              (cell) => cell.letter.letter,
            )
            .join();

        final findWord = dictionary.words.get(word);
        print("$word: $findWord");

        setState(() {
          _indexes.clear();
        });
      },
      child: GridView.count(
        crossAxisCount: Constants.gridSize,
        children: _letters
            .map(
              (entry) => Container(
                decoration: BoxDecoration(
                  color: _indexes.contains(entry.index)
                      ? Colors.cyan
                      : Colors.cyan[50],
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    entry.letter.letter,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            )
            .toList(),
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
