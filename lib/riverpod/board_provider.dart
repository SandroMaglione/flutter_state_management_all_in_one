import 'package:flutter_state_management_all_in_one/board.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_provider.g.dart';

@riverpod
class BoardNotifier extends _$BoardNotifier {
  @override
  Board build(GridRepository gridRepository) =>
      Board.init(gridRepository.generateGrid);

  void searchWord(Dictionary dictionary, Set<GridIndex> indexes) {
    final word = indexes
        .map(
          (index) => state.cells.firstWhere(
            (cell) => cell.index == index,
          ),
        )
        .map(
          (cell) => cell.letter.letter,
        )
        .join();

    final findWord = dictionary.words.get(word);
    if (findWord != null) {
      state = state.found(word, findWord);
    }
  }
}
