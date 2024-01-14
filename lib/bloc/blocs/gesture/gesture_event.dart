part of 'gesture_bloc.dart';

@immutable
sealed class GestureEvent {
  const GestureEvent();
}

class OnPanStart extends GestureEvent {
  final DragStartDetails details;
  const OnPanStart(this.details);
}

class OnPanUpdate extends GestureEvent {
  final DragUpdateDetails details;
  const OnPanUpdate(this.details);
}

class OnPanEnd extends GestureEvent {
  final DragEndDetails details;
  const OnPanEnd(this.details);
}
