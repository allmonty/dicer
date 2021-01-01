import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'board_model.dart';
import 'dice.dart';
import 'dice_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dicer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BoardModel(),
      child: Scaffold(
        body: Center(
          child: DicesBoard(),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 42.0,
            child: BoardResult(),
          ),
        ),
        floatingActionButton: AddButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class BoardResult extends StatelessWidget {
  const BoardResult({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Result: ${Provider.of<BoardModel>(context).total}",
      style: TextStyle(fontSize: 30),
    );
  }
}

class DicesBoard extends StatelessWidget {
  const DicesBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, board, _) {
        return GridView.count(
          crossAxisCount: 3,
          children: board.items.map((diceModel) {
            return ChangeNotifierProvider.value(
              value: diceModel,
              child: Consumer<DiceModel>(builder: (context, dice, _) {
                return Dice(
                  size: diceModel.size,
                  result: diceModel.result,
                  onTap: diceModel.roll,
                );
              }),
            );
          }).toList(),
        );
      },
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Provider.of<BoardModel>(context, listen: false).rerollAll(),
      tooltip: 'Increment',
      child: Icon(Icons.autorenew),
    );
  }
}
