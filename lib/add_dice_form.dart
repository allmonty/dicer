import 'package:flutter/material.dart';

class AddDiceForm extends StatefulWidget {
  const AddDiceForm({super.key, this.diceSize = 6, this.quantity = 1, this.addDice, this.showAdds});

  final int? diceSize;
  final int? quantity;
  final Function? addDice;
  final Function()? showAdds;

  @override
  AddDiceFormState createState() => AddDiceFormState();
}

class AddDiceFormState extends State<AddDiceForm> {
  AddDiceFormState();

  int? diceSize;
  int? quantity;

  @override
  void initState() {
    super.initState();
    diceSize = widget.diceSize;
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          initialValue: '${widget.diceSize}',
          onChanged: (value) {
            setState(() => diceSize = int.parse(value == "" ? "0" : value));
          },
          decoration: InputDecoration(icon: Text("D"), labelText: "Size of dice"),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          initialValue: '${widget.quantity}',
          onChanged: (value) {
            setState(() => quantity = int.parse(value == "" ? "0" : value));
          },
          decoration: InputDecoration(icon: Text("#"), labelText: "Amount of dice"),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.outline,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Icon(Icons.add),
          onPressed: () {
            widget.showAdds?.call();
            widget.addDice!(diceSize, quantity: quantity);
          },
        ),
      ],
    );
  }
}
