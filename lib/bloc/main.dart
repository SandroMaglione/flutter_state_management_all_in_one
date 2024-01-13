import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/board/board_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/gesture/gesture_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/grid.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';

final dictionary = Dictionary();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dictionary.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc State Management',
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GridSettings>(
            create: (context) => const GridSettingsDefault(),
          ),
        ],
        child: Builder(
          builder: (context) => RepositoryProvider<GridRepository>(
            create: (context) => GridRepositoryImpl(
              Random(),
              context.read<GridSettings>(),
              const EnglishAlphabet(),
            ),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GestureBloc(
                    context.read<GridSettings>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => BoardBloc(
                    context.read<GridRepository>(),
                  )..add(InitBoard()),
                ),
              ],
              child: Builder(builder: (context) {
                final gridSettings = context.read<GridSettings>();
                return Column(
                  children: [
                    Container(
                      height: gridSettings.gridDimension,
                      width: gridSettings.gridDimension,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Grid(),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
