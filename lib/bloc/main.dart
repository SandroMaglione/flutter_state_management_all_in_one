import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_all_in_one/alphabet.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/board/board_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/dictionary/dictionary_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/blocs/gesture/gesture_bloc.dart';
import 'package:flutter_state_management_all_in_one/bloc/grid.dart';
import 'package:flutter_state_management_all_in_one/grid_repository.dart';
import 'package:flutter_state_management_all_in_one/grid_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc State Management',
      home: Scaffold(
        body: Center(
          child: BlocProvider(
            create: (context) => DictionaryBloc()..add(OnInitDictionary()),
            child: BlocBuilder<DictionaryBloc, DictionaryState>(
              builder: (context, state) => switch (state) {
                InitDictionary() => const Placeholder(),
                LoadingWords() => const CircularProgressIndicator(),
                InvalidDictionary() => const Placeholder(),
                ValidDictionary(dictionary: final dictionary) =>
                  MultiRepositoryProvider(
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
                                dictionary,
                              ),
                            ),
                            BlocProvider(
                              create: (context) => BoardBloc(
                                context.read<GridRepository>(),
                              )..add(InitBoard()),
                            ),
                          ],
                          child: Builder(
                            builder: (context) {
                              final gridSettings = context.read<GridSettings>();
                              return SizedBox(
                                height: gridSettings.gridDimension,
                                width: gridSettings.gridDimension,
                                child: const Grid(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
