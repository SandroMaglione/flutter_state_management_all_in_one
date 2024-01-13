import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:itrie/itrie.dart';

final class Dictionary {
  Dictionary._();

  static final Dictionary _dictionary = Dictionary._();
  factory Dictionary() => _dictionary;

  ITrie<Word> words = ITrie.empty();

  Future<void> init() async {
    /// Source: https://github.com/dwyl/english-words/blob/master/words.txt
    final file = await rootBundle.loadString('words.txt');

    try {
      words = ITrie<Word>.fromIterable(
        file
            .split("\n")
            .map(
              (key) => (
                key.toUpperCase(),
                (
                  points: key
                      .toUpperCase()
                      .split("")
                      .map(
                        (letter) => const EnglishAlphabet().letterMap[letter]!,
                      )
                      .reduce(
                        (acc, points) => acc + points,
                      ),
                ),
              ),
            )
            .toList(),
      );
      print("Init ${words.length} words");
    } catch (e) {
      print('Error loading words: $e');
    }
  }
}
