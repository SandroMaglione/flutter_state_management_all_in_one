import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/get/board_controller.dart';
import 'package:flutter_state_management_all_in_one/get/dictionary_controller.dart';
import 'package:flutter_state_management_all_in_one/get/gesture_controller.dart';
import 'package:flutter_state_management_all_in_one/grid_layout.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:get/get.dart';

const gridSettings = GridSettingsDefault();

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final dictionaryController = Get.put(DictionaryController());
    return FutureBuilder(
      future: dictionaryController.dictionary,
      builder: (context, snapshot) => switch (snapshot.connectionState) {
        ConnectionState.none => const Placeholder(),
        ConnectionState.waiting =>
          const Center(child: CircularProgressIndicator()),
        ConnectionState.active =>
          const Center(child: CircularProgressIndicator()),
        ConnectionState.done => snapshot.error != null
            ? Center(
                child: Text("Error: ${snapshot.error}"),
              )
            : !snapshot.hasData
                ? const Text('Missing dictionary')
                : GetBuilder(
                    init: BoardController(),
                    builder: (boardController) => GetBuilder(
                      init: GestureController(),
                      builder: (gestureController) => GridLayout(
                        gridSettings: gridSettings,
                        foundWords: boardController.board.foundWords.length,
                        points: boardController.board.points,
                        cells: boardController.board.cells,
                        isSelected: gestureController.gesture.isSelected,
                        onPanStart: (details) => gestureController.onPanStart(
                          gridSettings,
                          details,
                        ),
                        onPanUpdate: (details) => gestureController.onPanUpdate(
                          gridSettings,
                          details,
                        ),
                        onPanEnd: (_) {
                          boardController.searchWord(
                            snapshot.data!,
                            gestureController.gesture.indexes,
                          );
                          gestureController.onPanEnd();
                        },
                      ),
                    ),
                  ),
      },
    );
  }
}
