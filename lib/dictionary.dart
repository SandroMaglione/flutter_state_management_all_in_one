import 'dart:isolate';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:itrie/itrie.dart';

final class Dictionary {
  final ITrie<Word> words;
  const Dictionary._(this.words);

  factory Dictionary() => Dictionary._(ITrie.empty());

  static Future<Dictionary> init() async {
    final file = await rootBundle.loadString('assets/words.txt');
    final iterable = file.split("\n").map(
          (key) => (
            key.toUpperCase(),
            (
              points: key
                  .toUpperCase()
                  .split("")
                  .map(
                    (letter) =>
                        const EnglishAlphabet().letterMap[letter]!.points,
                  )
                  .reduce(
                    (acc, points) => acc + points,
                  ),
            ),
          ),
        );

    return Isolate.run<Dictionary>(
      () => Dictionary._(
        ITrie<Word>.fromIterable(iterable),
      ),
    );
  }
}
