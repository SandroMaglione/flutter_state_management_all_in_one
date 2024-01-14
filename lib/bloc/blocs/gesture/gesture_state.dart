part of 'gesture_bloc.dart';

class GestureState {
  final Set<GridIndex> indexes;
  const GestureState._(this.indexes);

  factory GestureState.empty() => const GestureState._({});

  GestureState add(GridIndex gridIndex) =>
      GestureState._({...indexes, gridIndex});

  bool isSelected(GridIndex index) => indexes.contains(index);
}
