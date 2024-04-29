import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/components/term_widget.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TermGrid extends StatelessWidget {
  const TermGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
    final appModel = appModelRepository.getOrDefault();
    final textToSpeech = GetIt.I<TextToSpeech>();

    final terms = appModel.terms;
    final termsByCategory = terms.groupSetsBy((term) => term.category);

    const minCardWidth = 200;
    final width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        for (final category in termsByCategory.keys) ...[
          SliverToBoxAdapter(
            child: Card(
              child: ListTile(
                title: Text(category.target),
                subtitle: Text(category.origin),
                onTap: () => textToSpeech.speak(category.target),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (width / minCardWidth).floor(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final term = termsByCategory[category]!.elementAt(index);
                  return Card(
                    child: InkWell(
                      onTap: () => textToSpeech.speak(term.target),
                      child: TermWidget(term: term),
                    ),
                  );
                },
                childCount: termsByCategory[category]!.length,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
