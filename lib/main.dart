import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dice.dart';
import 'models/result_model.dart';
import 'models/board_model.dart';
import 'models/dice_model.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BoardModel()),
        ChangeNotifierProvider(create: (context) => ResultModel()),
      ],
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

void rerollAll(BoardModel board, ResultModel result) {
  board.items.forEach((element) => element.roll());
  result.update(board.total);
}

void reroll(DiceModel dice, ResultModel result) {
  int oldValue = dice.result;
  dice.roll();
  int newResult = result.result - oldValue + dice.result;
  result.update(newResult);
}

class BoardResult extends StatelessWidget {
  const BoardResult({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Result: ${Provider.of<ResultModel>(context).result}",
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
                  onTap: () => reroll(
                    diceModel,
                    Provider.of<ResultModel>(context, listen: false),
                  ),
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
      onPressed: () => rerollAll(
        Provider.of<BoardModel>(context, listen: false),
        Provider.of<ResultModel>(context, listen: false),
      ),
      tooltip: 'Increment',
      child: Icon(Icons.autorenew),
    );
  }
}
