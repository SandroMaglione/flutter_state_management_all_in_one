import 'package:flutter_state_management_all_in_one/typedefs.dart';

abstract interface class Alphabet {
  const Alphabet();

  Map<String, int> get letterMap => {
        "E": 1,
        "A": 1,
        "I": 1,
        "O": 1,
        "N": 1,
        "R": 1,
        "T": 1,
        "L": 1,
        "S": 1,
        "U": 1,
        "D": 2,
        "G": 2,
        "B": 3,
        "C": 3,
        "M": 3,
        "P": 3,
        "F": 4,
        "H": 4,
        "V": 4,
        "W": 4,
        "Y": 4,
        "K": 5,
        "J": 8,
        "X": 8,
        "Q": 10,
        "Z": 10,
      };

  /// https://en.wikipedia.org/wiki/Scrabble_letter_distributions
  List<Letter> get letters => [
        ...List.filled(12, (letter: "E", points: letterMap["E"]!)),
        ...List.filled(9, (letter: "A", points: letterMap["A"]!)),
        ...List.filled(9, (letter: "I", points: letterMap["I"]!)),
        ...List.filled(8, (letter: "O", points: letterMap["O"]!)),
        ...List.filled(6, (letter: "N", points: letterMap["N"]!)),
        ...List.filled(6, (letter: "R", points: letterMap["R"]!)),
        ...List.filled(6, (letter: "T", points: letterMap["T"]!)),
        ...List.filled(4, (letter: "L", points: letterMap["L"]!)),
        ...List.filled(4, (letter: "S", points: letterMap["S"]!)),
        ...List.filled(4, (letter: "U", points: letterMap["U"]!)),
        ...List.filled(4, (letter: "D", points: letterMap["D"]!)),
        ...List.filled(3, (letter: "G", points: letterMap["G"]!)),
        ...List.filled(2, (letter: "B", points: letterMap["B"]!)),
        ...List.filled(2, (letter: "C", points: letterMap["C"]!)),
        ...List.filled(2, (letter: "M", points: letterMap["M"]!)),
        ...List.filled(2, (letter: "P", points: letterMap["P"]!)),
        ...List.filled(2, (letter: "F", points: letterMap["F"]!)),
        ...List.filled(2, (letter: "H", points: letterMap["H"]!)),
        ...List.filled(2, (letter: "V", points: letterMap["V"]!)),
        ...List.filled(2, (letter: "W", points: letterMap["W"]!)),
        ...List.filled(2, (letter: "Y", points: letterMap["Y"]!)),
        ...List.filled(1, (letter: "K", points: letterMap["K"]!)),
        ...List.filled(1, (letter: "J", points: letterMap["J"]!)),
        ...List.filled(1, (letter: "X", points: letterMap["X"]!)),
        ...List.filled(1, (letter: "Q", points: letterMap["Q"]!)),
        ...List.filled(1, (letter: "Z", points: letterMap["Z"]!)),
      ];
}

class EnglishAlphabet extends Alphabet {
  const EnglishAlphabet();
}
