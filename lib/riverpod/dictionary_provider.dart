import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_provider.g.dart';

@riverpod
Future<Dictionary> dictionary(DictionaryRef ref) async {
  return Dictionary.init();
}
