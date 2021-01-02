import 'package:flutter/material.dart';
import 'dart:collection';

import 'dice_model.dart';

class BoardModel extends ChangeNotifier {
  final List<DiceModel> _items = [
    DiceModel(6),
    DiceModel(8),
    DiceModel(20),
    DiceModel(12),
    DiceModel(100),
  ];

  UnmodifiableListView<DiceModel> get items => UnmodifiableListView(_items);

  int get total => _items.fold(0, (total, dice) => total += dice.result);

  void add(int size) {
    _items.add(DiceModel(size));
    notifyListeners();
  }
}
