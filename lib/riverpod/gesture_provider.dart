import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management_all_in_one/gesture.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/riverpod/grid_settings_provider.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

class GestureNotifier extends StateNotifier<Gesture> {
  final GridSettings _gridSettings;
  GestureNotifier(this._gridSettings) : super(Gesture.empty());

  void onPanStart(DragStartDetails details) {
    final pos = _panIndex(details.localPosition);
    state = state.add(pos.index);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final pos = _panIndex(details.localPosition);
    if (pos.margin.$1 > _gridSettings.panMargin &&
        pos.margin.$1 < (1 - _gridSettings.panMargin) &&
        pos.margin.$2 > _gridSettings.panMargin &&
        pos.margin.$2 < (1 - _gridSettings.panMargin)) {
      state = state.add(pos.index);
    }
  }

  void onPanEnd() {
    state = Gesture.empty();
  }

  ({GridIndex index, GridMargin margin}) _panIndex(Offset localPosition) {
    final offset =
        localPosition / (_gridSettings.gridDimension / _gridSettings.gridSize);

    final index = (offset.dy.floor(), offset.dx.floor());
    final margin = (offset.dy - index.$1, offset.dx - index.$2);

    return (index: index, margin: margin);
  }
}

final gestureProvider = StateNotifierProvider<GestureNotifier, Gesture>((ref) {
  final gridSettings = ref.read(gridSettingsProvider);
  return GestureNotifier(gridSettings);
});
