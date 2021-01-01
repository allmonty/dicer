import 'package:flutter/material.dart';

class DiceView extends StatelessWidget {
  final state;
  const DiceView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.purple.withAlpha(50),
        onTap: state.roll,
        child: Container(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'D${state.widget.diceSize}',
              ),
              Text(
                '${state.result}',
                style: TextStyle(fontSize: 72),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
