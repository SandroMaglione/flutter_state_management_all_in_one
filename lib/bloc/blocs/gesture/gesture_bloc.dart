import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/gesture.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

part 'gesture_event.dart';

class GestureBloc extends Bloc<GestureEvent, Gesture> {
  final GridSettings _gridSettings;

  GestureBloc(this._gridSettings) : super(Gesture.empty()) {
    on<OnPanStart>(
      (event, emit) {
        final pos = _panIndex(event.details.localPosition);
        emit(state.add(pos.index));
      },
    );

    on<OnPanUpdate>(
      (event, emit) {
        final pos = _panIndex(event.details.localPosition);
        if (pos.margin.$1 > _gridSettings.panMargin &&
            pos.margin.$1 < (1 - _gridSettings.panMargin) &&
            pos.margin.$2 > _gridSettings.panMargin &&
            pos.margin.$2 < (1 - _gridSettings.panMargin)) {
          emit(state.add(pos.index));
        }
      },
    );

    on<OnPanEnd>(
      (event, emit) {
        emit(Gesture.empty());
      },
    );
  }

  ({GridIndex index, GridMargin margin}) _panIndex(Offset localPosition) {
    final offset =
        localPosition / (_gridSettings.gridDimension / _gridSettings.gridSize);

    final index = (offset.dy.floor(), offset.dx.floor());
    final margin = (offset.dy - index.$1, offset.dx - index.$2);

    return (index: index, margin: margin);
  }
}
