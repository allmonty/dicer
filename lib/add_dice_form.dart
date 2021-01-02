import 'package:flutter/material.dart';

class AddDiceForm extends StatefulWidget {
  AddDiceForm({
    Key key,
    this.diceSize = 6,
    this.quantity = 1,
    this.add,
  }) : super(key: key);

  final int diceSize;
  final int quantity;
  final Function add;

  @override
  _AddDiceFormState createState() => _AddDiceFormState(diceSize: diceSize, quantity: quantity);
}

class _AddDiceFormState extends State<AddDiceForm> {
  _AddDiceFormState({this.diceSize = 6, this.quantity = 1});

  int diceSize;
  int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(children: [
              TextFormField(
                initialValue: '${widget.diceSize}',
                onChanged: (value) {
                  setState(() => diceSize = int.parse(value));
                },
                decoration: InputDecoration(icon: Text("D")),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                initialValue: '${widget.quantity}',
                onChanged: (value) {
                  setState(() => quantity = int.parse(value));
                },
                decoration: InputDecoration(icon: Text("#")),
                keyboardType: TextInputType.number,
              ),
            ]),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: RaisedButton(
              child: Text("add", style: TextStyle(fontSize: 20)),
              onPressed: () => widget.add(diceSize, quantity: quantity),
            ),
          ),
        ],
      ),
    );
  }
}
