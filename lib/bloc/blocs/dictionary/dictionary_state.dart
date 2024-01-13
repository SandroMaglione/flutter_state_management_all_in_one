part of 'dictionary_bloc.dart';

@immutable
sealed class DictionaryState {
  const DictionaryState();
}

class InitDictionary extends DictionaryState {}

class LoadingWords extends DictionaryState {}

class InvalidDictionary extends DictionaryState {}

class ValidDictionary extends DictionaryState {
  final Dictionary dictionary;
  const ValidDictionary(this.dictionary);
}
