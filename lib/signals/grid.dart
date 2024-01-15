import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/board.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/gesture.dart';
import 'package:flutter_state_management_all_in_one/grid_layout.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:signals/signals_flutter.dart';

final gridSettings = signal(const GridSettingsDefault());
final gesture = signal(Gesture.empty());

final gridRepository = computed(
  () => GridRepositoryImpl(
    Random(),
    gridSettings.value,
    const EnglishAlphabet(),
  ),
);
final board = signal(Board.init(gridRepository.value.generateGrid));

final dictionary = futureSignal<Dictionary>(
  () => Dictionary.init(),
);

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final dictionaryAsync = dictionary.value;
      return dictionaryAsync.map(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text("Error: $e"),
        ),
        data: (dictionary) => GridLayout(
          gridSettings: gridSettings.value,
          foundWords: board.value.foundWords.length,
          points: board.value.points,
          cells: board.value.cells,
          isSelected: gesture.value.isSelected,
          onPanStart: (details) {
            final pos = _panIndex(gridSettings.value, details.localPosition);
            gesture.value = gesture.value.add(pos.index);
          },
          onPanUpdate: (details) {
            final pos = _panIndex(gridSettings.value, details.localPosition);
            if (pos.margin.$1 > gridSettings.value.panMargin &&
                pos.margin.$1 < (1 - gridSettings.value.panMargin) &&
                pos.margin.$2 > gridSettings.value.panMargin &&
                pos.margin.$2 < (1 - gridSettings.value.panMargin)) {
              gesture.value = gesture.value.add(pos.index);
            }
          },
          onPanEnd: (_) {
            _searchWord(dictionary, gesture.value.indexes);
            gesture.value = Gesture.empty();
          },
        ),
      );
    });
  }

  void _searchWord(Dictionary dictionary, Set<GridIndex> indexes) {
    final word = indexes
        .map(
          (index) => board.value.cells.firstWhere(
            (cell) => cell.index == index,
          ),
        )
        .map(
          (cell) => cell.letter.letter,
        )
        .join();

    final findWord = dictionary.words.get(word);
    if (findWord != null) {
      board.value = board.value.found(word, findWord);
    }
  }

  ({GridIndex index, GridMargin margin}) _panIndex(
      GridSettings gridSettings, Offset localPosition) {
    final offset =
        localPosition / (gridSettings.gridDimension / gridSettings.gridSize);

    final index = (offset.dy.floor(), offset.dx.floor());
    final margin = (offset.dy - index.$1, offset.dx - index.$2);

    return (index: index, margin: margin);
  }
}
