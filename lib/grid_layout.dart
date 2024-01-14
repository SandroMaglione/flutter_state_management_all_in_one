import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/cell_card.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

class GridLayout extends StatelessWidget {
  final int foundWords;
  final int points;
  final GridSettings gridSettings;
  final List<GridCell> cells;
  final void Function(DragStartDetails details) onPanStart;
  final void Function(DragUpdateDetails details) onPanUpdate;
  final void Function(DragEndDetails details) onPanEnd;
  final bool Function(GridIndex index) isSelected;

  const GridLayout({
    required this.gridSettings,
    required this.foundWords,
    required this.points,
    required this.cells,
    required this.onPanEnd,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Found $foundWords words | $points points",
          ),
          GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
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
                children: cells
                    .map(
                      (gridCell) => CellCard(
                        gridCell: gridCell,
                        isSelected: isSelected(gridCell.index),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
