import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management_all_in_one/grid_layout.dart';
import 'package:flutter_state_management_all_in_one/riverpod/board_provider.dart';
import 'package:flutter_state_management_all_in_one/riverpod/dictionary_provider.dart';
import 'package:flutter_state_management_all_in_one/riverpod/gesture_provider.dart';
import 'package:flutter_state_management_all_in_one/riverpod/grid_repository_provider.dart';
import 'package:flutter_state_management_all_in_one/riverpod/grid_settings_provider.dart';

class Grid extends ConsumerWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dictionaryAsync = ref.watch(dictionaryProvider);

    final gridRepository = ref.watch(gridRepositoryProvider);
    final gesture = ref.watch(gestureNotifierProvider);
    final gridSettings = ref.watch(gridSettingsProvider);
    final board = ref.watch(boardNotifierProvider(gridRepository));

    final gestureNotifier = ref.watch(gestureNotifierProvider.notifier);

    return dictionaryAsync.map(
      loading: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e) => Center(
        child: Text("Error: $e"),
      ),
      data: (dictionary) => GridLayout(
        gridSettings: gridSettings,
        foundWords: board.foundWords.length,
        points: board.points,
        cells: board.cells,
        isSelected: gesture.isSelected,
        onPanStart: (details) =>
            gestureNotifier.onPanStart(gridSettings, details),
        onPanUpdate: (details) =>
            gestureNotifier.onPanUpdate(gridSettings, details),
        onPanEnd: (_) {
          final boardNotifier = ref.read(
            boardNotifierProvider(gridRepository).notifier,
          );

          boardNotifier.searchWord(dictionary.value, gesture.indexes);
          gestureNotifier.onPanEnd();
        },
      ),
    );
  }
}
