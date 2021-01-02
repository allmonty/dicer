import 'package:flutter/material.dart';

class ResultModel extends ChangeNotifier {
  int _result = 0;

  int get result => _result;

  void update(int result) {
    _result = result;
    notifyListeners();
  }
}
