import 'dart:math';

import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

abstract interface class GridRepository {
  const GridRepository();
  List<GridCell> get generateGrid;
}

class GridRepositoryImpl implements GridRepository {
  final Random _random;
  final GridSettings _gridSettings;
  final Alphabet _alphabet;
  const GridRepositoryImpl(this._random, this._gridSettings, this._alphabet);

  @override
  List<GridCell> get generateGrid {
    var extractList = [..._alphabet.letters];

    List<GridCell> cells = [];
    for (int i = 0; i < pow(_gridSettings.gridSize, 2); ++i) {
      final letter = extractList.removeAt(
        _random.nextInt(extractList.length),
      );

      final index = (
        (i / _gridSettings.gridSize).floor(),
        i % _gridSettings.gridSize,
      );

      cells.add((index: index, letter: letter));
    }

    return cells;
  }
}
