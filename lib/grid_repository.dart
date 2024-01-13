import 'dart:math';

import 'package:flutter_state_management_all_in_one/constants.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

abstract interface class GridRepository {
  const GridRepository();
  List<GridCell> get generateGrid;
}

class GridRepositoryImpl implements GridRepository {
  final Random _random;
  const GridRepositoryImpl(this._random);

  @override
  List<GridCell> get generateGrid {
    var extractList = [...Constants.letters];

    List<GridCell> cells = [];
    for (var i = 0; i < Constants.gridSize * Constants.gridSize; ++i) {
      final letter = extractList.removeAt(_random.nextInt(extractList.length));
      final index = ((i / Constants.gridSize).floor(), i % Constants.gridSize);

      cells.add((index: index, letter: letter));
    }

    return cells;
  }
}
