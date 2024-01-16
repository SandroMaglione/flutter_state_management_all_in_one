import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/gesture.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gesture_provider.g.dart';

@riverpod
class GestureNotifier extends _$GestureNotifier {
  @override
  Gesture build() => Gesture.empty();

  void onPanStart(GridSettings gridSettings, DragStartDetails details) {
    final pos = _panIndex(gridSettings, details.localPosition);
    state = state.add(pos.index);
  }

  void onPanUpdate(GridSettings gridSettings, DragUpdateDetails details) {
    final pos = _panIndex(gridSettings, details.localPosition);
    if (pos.margin.$1 > gridSettings.panMargin &&
        pos.margin.$1 < (1 - gridSettings.panMargin) &&
        pos.margin.$2 > gridSettings.panMargin &&
        pos.margin.$2 < (1 - gridSettings.panMargin)) {
      state = state.add(pos.index);
    }
  }

  void onPanEnd() {
    state = Gesture.empty();
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
