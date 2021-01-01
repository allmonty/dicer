import 'package:flutter/material.dart';
import 'dart:math';

class DiceModel extends ChangeNotifier {
  final int _size;
  int _result = 0;

  DiceModel(this._size);

  int get size => _size;
  int get result => _result;

  void roll() {
    _result = 1 + Random().nextInt(size);
    notifyListeners();
  }
}
