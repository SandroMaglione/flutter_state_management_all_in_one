import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/board/board_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/gesture/gesture_bloc.dart';
import 'package:flutter_state_management_all_in_one/cell_card.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final gestureBloc = context.read<GestureBloc>();
    final gestureBlocState = context.watch<GestureBloc>().state;
    final gridSettings = context.watch<GridSettings>();
    final boardBloc = context.watch<BoardBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Found ${boardBloc.state.foundWords.length} words | ${boardBloc.state.points} points",
        ),
        GestureDetector(
          onPanStart: (details) => gestureBloc.add(OnPanStart(details)),
          onPanUpdate: (details) => gestureBloc.add(OnPanUpdate(details)),
          onPanEnd: (details) {
            boardBloc
                .add(SearchWord(context.read<GestureBloc>().state.indexes));
            gestureBloc.add(OnPanEnd(details));
          },
          child: Container(
            width: gridSettings.gridDimension,
            height: gridSettings.gridDimension,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              crossAxisCount: gridSettings.gridSize,
              children: boardBloc.state.cells
                  .map(
                    (gridCell) => CellCard(
                      gridCell: gridCell,
                      isSelected: gestureBlocState.isSelected(gridCell.index),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
