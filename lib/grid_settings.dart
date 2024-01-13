abstract interface class GridSettings {
  const GridSettings();

  int get gridSize => 4;
  double get gridDimension => 600;
  double get panMargin => 0.05;
}

class GridSettingsDefault extends GridSettings {
  const GridSettingsDefault();
}
