import 'package:flutter/services.dart' show rootBundle;
import 'package:itrie/itrie.dart';

typedef Word = ({int points});

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
            .where(
              (key) => key.length >= 2 && RegExp(r'^[A-Za-z]+$').hasMatch(key),
            )
            .map(
              (key) => (key.toUpperCase(), (points: 0)),
            )
            .toList(),
      );
      print("Init ${words.length} words");
    } catch (e) {
      print('Error loading words: $e');
    }
  }
}
