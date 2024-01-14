part of 'board_bloc.dart';

class BoardState {
  final List<GridCell> cells;
  final ITrie<Word> foundWords;
  const BoardState(this.cells, this.foundWords);

  factory BoardState.init(List<GridCell> cells) => BoardState(
        cells,
        ITrie.empty(),
      );

  factory BoardState.empty() => BoardState(
        [],
        ITrie.empty(),
      );

  BoardState found(String key, Word word) => BoardState(
        cells,
        foundWords.insert(key, word),
      );

  int get points => foundWords.fold(
        0,
        (acc, e) => acc + e.$2.points,
      );
}
