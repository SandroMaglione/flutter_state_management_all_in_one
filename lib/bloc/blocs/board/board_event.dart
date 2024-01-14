part of 'board_bloc.dart';

@immutable
sealed class BoardEvent {
  const BoardEvent();
}

class InitBoard extends BoardEvent {}

class SearchWord extends BoardEvent {
  final Set<GridIndex> indexes;
  const SearchWord(this.indexes);
}
