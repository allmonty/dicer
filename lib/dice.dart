import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  const Dice({Key key, this.size, this.result, this.onTap}) : super(key: key);

  final int size;
  final int result;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.purple.withAlpha(50),
        onTap: onTap,
        child: Container(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('D$size'),
              Text('$result', style: TextStyle(fontSize: 72)),
            ],
          ),
        ),
      ),
    );
  }
}
