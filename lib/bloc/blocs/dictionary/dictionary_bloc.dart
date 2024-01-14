import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc() : super(InitDictionary()) {
    on<OnInitDictionary>(
      (event, emit) async {
        emit(LoadingWords());

        try {
          final dictionary = await Dictionary.init();
          emit(ValidDictionary(dictionary));
        } catch (e) {
          emit(InvalidDictionary(e));
        }
      },
    );
  }
}
