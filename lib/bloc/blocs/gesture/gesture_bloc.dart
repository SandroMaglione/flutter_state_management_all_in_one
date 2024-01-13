import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/main.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

part 'gesture_event.dart';
part 'gesture_state.dart';

class GestureBloc extends Bloc<GestureEvent, GestureState> {
  final GridSettings _gridSettings;

  GestureBloc(this._gridSettings) : super(GestureState.empty()) {
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
        final word = state._indexes
            .map(
              (index) => event.letters.firstWhere(
                (cell) => cell.index == index,
              ),
            )
            .map(
              (cell) => cell.letter.letter,
            )
            .join();

        final findWord = dictionary.words.get(word);

        // TODO
        print("$word: $findWord");

        emit(GestureState.empty());
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
