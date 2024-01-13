import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

class CellCard extends StatelessWidget {
  final GridCell gridCell;
  final bool isSelected;
  const CellCard({
    required this.gridCell,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.cyan : Colors.cyan[50],
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          "${gridCell.letter.letter} (${gridCell.letter.points})",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
