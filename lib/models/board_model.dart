import 'package:flutter/material.dart';
import 'dart:collection';

import 'dice_model.dart';

class BoardModel extends ChangeNotifier {
  final List<DiceModel> _items = [DiceModel(6), DiceModel(6)];

  UnmodifiableListView<DiceModel> get items => UnmodifiableListView(_items);

  int get total => _items.fold(0, (total, dice) => total += dice.result);

  void add(int size, {int quantity = 1}) {
    for (var _ in Iterable.generate(quantity)) {
      _items.add(DiceModel(size));
    }

    notifyListeners();
  }

  void remove(DiceModel element) {
    _items.remove(element);
    notifyListeners();
  }
}
