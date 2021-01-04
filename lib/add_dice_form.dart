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
  _AddDiceFormState createState() =>
      _AddDiceFormState(diceSize: diceSize, quantity: quantity);
}

class _AddDiceFormState extends State<AddDiceForm> {
  _AddDiceFormState({this.diceSize = 6, this.quantity = 1});

  int diceSize;
  int quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          initialValue: '${widget.diceSize}',
          onChanged: (value) {
            setState(() => diceSize = int.parse(value));
          },
          decoration: InputDecoration(
            icon: Text("D"),
            labelText: "Size of dice",
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          initialValue: '${widget.quantity}',
          onChanged: (value) {
            setState(() => quantity = int.parse(value));
          },
          decoration: InputDecoration(
            icon: Text("#"),
            labelText: "Amount of dice",
          ),
          keyboardType: TextInputType.number,
        ),
        RaisedButton(
          color: Theme.of(context).accentColor,
          child: Icon(Icons.add),
          onPressed: () => widget.add(diceSize, quantity: quantity),
        ),
      ],
    );
  }
}
