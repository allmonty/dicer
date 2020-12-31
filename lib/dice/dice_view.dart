import 'package:flutter/material.dart';

class DiceView extends StatelessWidget {
  final state;
  const DiceView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: state.roll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: Text('D${state.widget.diceSize}'),
            ),
            Text(
              '${state.result}',
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
