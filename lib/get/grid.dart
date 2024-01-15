import 'package:flutter/material.dart';
import 'package:flutter_state_management_all_in_one/dictionary.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final dictionary = Dictionary.init();
}

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final dictionaryController = Get.put(DictionaryController());
    return FutureBuilder(
      future: dictionaryController.dictionary,
      builder: (context, snapshot) => switch (snapshot.connectionState) {
        ConnectionState.none => const Placeholder(),
        ConnectionState.waiting =>
          const Center(child: CircularProgressIndicator()),
        ConnectionState.active =>
          const Center(child: CircularProgressIndicator()),
        ConnectionState.done => snapshot.error != null
            ? Center(
                child: Text("Error: ${snapshot.error}"),
              )
            : const Placeholder(),
      },
    );
  }
}
