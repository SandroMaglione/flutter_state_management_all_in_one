import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/board/board_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/gesture/gesture_bloc.dart';
import 'package:flutter_state_management_all_in_one/grid_layout.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final gestureBloc = context.read<GestureBloc>();
    final gestureBlocState = context.watch<GestureBloc>().state;
    final gridSettings = context.watch<GridSettings>();
    final boardBloc = context.watch<BoardBloc>();
    return GridLayout(
      gridSettings: gridSettings,
      foundWords: boardBloc.state.foundWords.length,
      points: boardBloc.state.points,
      cells: boardBloc.state.cells,
      isSelected: gestureBlocState.isSelected,
      onPanStart: (details) {
        gestureBloc.add(OnPanStart(details));
      },
      onPanUpdate: (details) {
        gestureBloc.add(OnPanUpdate(details));
      },
      onPanEnd: (details) {
        boardBloc.add(SearchWord(context.read<GestureBloc>().state.indexes));
        gestureBloc.add(OnPanEnd(details));
      },
    );
  }
}
