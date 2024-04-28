import 'package:micha_core/micha_core.dart';

class MemoryCardModel<T> {
  final T value;
  bool isMatched = false;
  bool isSelected = false;

  bool get isFaceUp => isMatched || isSelected;

  MemoryCardModel(this.value);
}

class MemoryModel<T> {
  final int cardCopyCount;
  final List<MemoryCardModel<T>> _cards = [];

  Iterable<MemoryCardModel<T>> get cards => _cards;
  Set<MemoryCardModel<T>> get selectedCards =>
      Set.unmodifiable(_cards.where((card) => card.isSelected));

  MemoryModel(Set<T> uniqueValues, {this.cardCopyCount = 2}) {
    cardCopyCount.times(
      (_) => _cards.addAll(uniqueValues.map((value) => MemoryCardModel(value))),
    );
    _cards.shuffle();
  }

  void onTapCard(MemoryCardModel<T> card) {
    if (card.isMatched) return;

    if (selectedCards.length == cardCopyCount) {
      for (var selectedCard in selectedCards) {
        selectedCard.isSelected = false;
      }
    }

    if (card.isSelected) {
      return;
    }

    card.isSelected = true;
    if (selectedCards.length == cardCopyCount &&
        selectedCards
            .every((selectedCard) => selectedCard.value == card.value)) {
      for (var selectedCard in selectedCards) {
        selectedCard.isSelected = false;
        selectedCard.isMatched = true;
      }
    }
  }
}
