part of 'gesture_bloc.dart';

class GestureState {
  final Set<GridIndex> _indexes;
  const GestureState._(this._indexes);

  factory GestureState.empty() => const GestureState._({});

  GestureState add(GridIndex gridIndex) =>
      GestureState._({..._indexes, gridIndex});

  bool isSelected(GridIndex index) => _indexes.contains(index);
}
