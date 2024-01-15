import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:itrie/itrie.dart';

class Board {
  final List<GridCell> cells;
  final ITrie<Word> foundWords;
  const Board(this.cells, this.foundWords);

  factory Board.init(List<GridCell> cells) => Board(
        cells,
        ITrie.empty(),
      );

  factory Board.empty() => Board(
        [],
        ITrie.empty(),
      );

  Board found(String key, Word word) => Board(
        cells,
        foundWords.insert(key, word),
      );

  int get points => foundWords.fold(
        0,
        (acc, e) => acc + e.$2.points,
      );
}
