import 'package:flutter_state_management_all_in_one/typedefs.dart';

class Gesture {
  final Set<GridIndex> indexes;
  const Gesture._(this.indexes);

  factory Gesture.empty() => const Gesture._({});

  Gesture add(GridIndex gridIndex) => Gesture._({...indexes, gridIndex});

  bool isSelected(GridIndex index) => indexes.contains(index);
}
