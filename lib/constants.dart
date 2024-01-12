typedef Letter = ({String letter, int points});

abstract class Constants {
  static const gridSize = 4;
  static const double gridDimension = 600;
  static const double panMargin = 0.05;

  /// https://en.wikipedia.org/wiki/Scrabble_letter_distributions
  static final List<Letter> letters = [
    ...List.filled(12, (letter: "E", points: 1)),
    ...List.filled(9, (letter: "A", points: 1)),
    ...List.filled(9, (letter: "I", points: 1)),
    ...List.filled(8, (letter: "O", points: 1)),
    ...List.filled(6, (letter: "N", points: 1)),
    ...List.filled(6, (letter: "R", points: 1)),
    ...List.filled(6, (letter: "T", points: 1)),
    ...List.filled(4, (letter: "L", points: 1)),
    ...List.filled(4, (letter: "S", points: 1)),
    ...List.filled(4, (letter: "U", points: 1)),
    ...List.filled(4, (letter: "D", points: 2)),
    ...List.filled(3, (letter: "G", points: 2)),
    ...List.filled(2, (letter: "B", points: 3)),
    ...List.filled(2, (letter: "C", points: 3)),
    ...List.filled(2, (letter: "M", points: 3)),
    ...List.filled(2, (letter: "P", points: 3)),
    ...List.filled(2, (letter: "F", points: 4)),
    ...List.filled(2, (letter: "H", points: 4)),
    ...List.filled(2, (letter: "V", points: 4)),
    ...List.filled(2, (letter: "W", points: 4)),
    ...List.filled(2, (letter: "Y", points: 4)),
    ...List.filled(1, (letter: "K", points: 5)),
    ...List.filled(1, (letter: "J", points: 8)),
    ...List.filled(1, (letter: "X", points: 8)),
    ...List.filled(1, (letter: "Q", points: 10)),
    ...List.filled(1, (letter: "Z", points: 10)),
  ];
}
