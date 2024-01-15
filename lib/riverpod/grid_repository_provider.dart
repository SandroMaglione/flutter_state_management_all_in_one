import 'dart:math';

import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/riverpod/grid_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grid_repository_provider.g.dart';

@riverpod
GridRepository gridRepository(GridRepositoryRef ref) {
  final gridSettings = ref.watch(gridSettingsProvider);
  return GridRepositoryImpl(
    Random(),
    gridSettings,
    const EnglishAlphabet(),
  );
}
