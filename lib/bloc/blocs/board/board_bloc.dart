import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/typedefs.dart';
import 'package:itrie/itrie.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final GridRepository _gridRepository;
  final Dictionary _dictionary;

  BoardBloc(this._gridRepository, this._dictionary)
      : super(BoardState.empty()) {
    on<InitBoard>(
      (event, emit) {
        emit(BoardState.init(_gridRepository.generateGrid));
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
