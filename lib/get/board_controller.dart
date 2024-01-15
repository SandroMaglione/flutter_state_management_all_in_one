import 'dart:math';

import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/board.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:get/get.dart';

import 'grid.dart';

final _gridRepository = GridRepositoryImpl(
  Random(),
  gridSettings,
  const EnglishAlphabet(),
);

class BoardController extends GetxController {
  var board = Board.init(_gridRepository.generateGrid);

  void searchWord(Dictionary dictionary, Set<GridIndex> indexes) {
    final word = indexes
        .map(
          (index) => board.cells.firstWhere(
            (cell) => cell.index == index,
          ),
        )
        .map(
          (cell) => cell.letter.letter,
        )
        .join();

    final findWord = dictionary.words.get(word);
    if (findWord != null) {
      board = board.found(word, findWord);
      update();
    }
  }
}
