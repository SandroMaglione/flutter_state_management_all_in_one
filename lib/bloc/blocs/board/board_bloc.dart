import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/board.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';

part 'board_event.dart';

class BoardBloc extends Bloc<BoardEvent, Board> {
  final GridRepository _gridRepository;
  final Dictionary _dictionary;

  BoardBloc(this._gridRepository, this._dictionary) : super(Board.empty()) {
    on<InitBoard>(
      (event, emit) {
        emit(Board.init(_gridRepository.generateGrid));
      },
    );

    on<SearchWord>(
      (event, emit) {
        final word = event.indexes
            .map(
              (index) => state.cells.firstWhere(
                (cell) => cell.index == index,
              ),
            )
            .map(
              (cell) => cell.letter.letter,
            )
            .join();

        final findWord = _dictionary.words.get(word);
        if (findWord != null) {
          emit(state.found(word, findWord));
        }
      },
    );
  }
}
