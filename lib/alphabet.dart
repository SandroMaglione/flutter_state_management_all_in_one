import 'package:flutter_state_management_all_in_one/typedefs.dart';

abstract interface class Alphabet {
  const Alphabet();

  /// https://en.wikipedia.org/wiki/Scrabble_letter_distributions
  Map<String, ({int points, int frequency})> get letterMap => {
        "E": (points: 1, frequency: 12),
        "A": (points: 1, frequency: 9),
        "I": (points: 1, frequency: 9),
        "O": (points: 1, frequency: 8),
        "N": (points: 1, frequency: 6),
        "R": (points: 1, frequency: 6),
        "T": (points: 1, frequency: 6),
        "L": (points: 1, frequency: 4),
        "S": (points: 1, frequency: 4),
        "U": (points: 1, frequency: 4),
        "D": (points: 2, frequency: 4),
        "G": (points: 2, frequency: 2),
        "B": (points: 3, frequency: 2),
        "C": (points: 3, frequency: 2),
        "M": (points: 3, frequency: 2),
        "P": (points: 3, frequency: 2),
        "F": (points: 4, frequency: 2),
        "H": (points: 4, frequency: 2),
        "V": (points: 4, frequency: 2),
        "W": (points: 4, frequency: 2),
        "Y": (points: 4, frequency: 2),
        "K": (points: 5, frequency: 1),
        "J": (points: 8, frequency: 1),
        "X": (points: 8, frequency: 1),
        "Q": (points: 10, frequency: 1),
        "Z": (points: 10, frequency: 1),
      };

  List<Letter> get letters => letterMap.entries
      .expand(
        (entry) => List.filled(
          entry.value.frequency,
          (letter: entry.key, points: entry.value.points),
        ),
      )
      .toList();
}

class EnglishAlphabet extends Alphabet {
  const EnglishAlphabet();
}
