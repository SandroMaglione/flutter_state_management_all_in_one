part of 'board_bloc.dart';

@immutable
sealed class BoardEvent {
  const BoardEvent();
}

class InitBoard extends BoardEvent {}
