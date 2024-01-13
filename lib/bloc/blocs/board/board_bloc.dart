import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

part 'board_event.dart';

class BoardBloc extends Bloc<BoardEvent, List<GridCell>> {
  final GridRepository _gridRepository;

  BoardBloc(this._gridRepository) : super([]) {
    on<InitBoard>(
      (event, emit) {
        emit(_gridRepository.generateGrid);
      },
    );
  }
}
