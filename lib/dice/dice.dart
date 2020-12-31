import 'dart:math';
import 'package:flutter/material.dart';

import './dice_view.dart';

class Dice extends StatefulWidget {
  const Dice({
    Key key,
    this.diceSize = 6,
  }) : super(key: key);

  final int diceSize;

  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int result = 0;

  @override
  Widget build(BuildContext context) => DiceView(this);

  void roll() => setState(() {
        result = 1 + Random().nextInt(widget.diceSize);
      });
}
