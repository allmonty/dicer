import 'dart:collection';

import 'package:flutter/material.dart';

import './dice/dice.dart';

class BoardModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Dice> _items = [
    Dice(diceSize: 20),
    Dice(diceSize: 12),
    Dice(diceSize: 6),
  ];

  UnmodifiableListView<Dice> get items => UnmodifiableListView(_items);

  void add(Dice item) {
    _items.add(item);
    notifyListeners();
  }
}
