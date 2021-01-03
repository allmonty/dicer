import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  const Dice({Key key, this.size, this.result, this.onTap, this.longPress})
      : super(key: key);

  final int size;
  final int result;
  final Function onTap;
  final Function longPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.purple.withAlpha(50),
        onTap: onTap,
        onLongPress: longPress,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('D$size'),
                Text('$result', style: TextStyle(fontSize: 72)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
