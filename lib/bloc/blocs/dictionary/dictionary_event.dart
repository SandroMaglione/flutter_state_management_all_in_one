part of 'dictionary_bloc.dart';

@immutable
sealed class DictionaryEvent {
  const DictionaryEvent();
}

class OnInitDictionary extends DictionaryEvent {}
