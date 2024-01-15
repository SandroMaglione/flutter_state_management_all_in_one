import 'package:flutter_state_management_all_in_one/grid_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grid_settings_provider.g.dart';

@riverpod
GridSettings gridSettings(GridSettingsRef ref) {
  return const GridSettingsDefault();
}
