import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/gesture.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:get/get.dart';

class GestureController extends GetxController {
  var gesture = Gesture.empty();

  void onPanStart(GridSettings gridSettings, DragStartDetails details) {
    final pos = _panIndex(
      gridSettings,
      details.localPosition,
    );

    gesture = gesture.add(pos.index);
    update();
  }

  void onPanUpdate(GridSettings gridSettings, DragUpdateDetails details) {
    final pos = _panIndex(gridSettings, details.localPosition);
    if (pos.margin.$1 > gridSettings.panMargin &&
        pos.margin.$1 < (1 - gridSettings.panMargin) &&
        pos.margin.$2 > gridSettings.panMargin &&
        pos.margin.$2 < (1 - gridSettings.panMargin)) {
      gesture = gesture.add(pos.index);
      update();
    }
  }

  void onPanEnd() {
    gesture = Gesture.empty();
    update();
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
