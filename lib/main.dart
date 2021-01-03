import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dice.dart';
import 'floating_modal_bottom_sheet.dart';
import 'add_dice_form.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BoardModel()),
          ChangeNotifierProvider(create: (context) => ResultModel()),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dicer"),
            BoardResult(),
          ],
        ),
      ),
      body: Center(
        child: DicesBoard(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return FloatingModalBottomSheet(
                    child: AddDiceForm(
                      add: Provider.of<BoardModel>(context, listen: false).add,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RerollBoardButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

void removeDice(DiceModel dice, BoardModel board, ResultModel result) {
  board.remove(dice);
  result.update(board.total);
}

class BoardResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Σ ${Provider.of<ResultModel>(context).result}",
      style: TextStyle(fontSize: 30),
    );
  }
}

class DicesBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, board, _) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: board.items.map((diceModel) {
              return ChangeNotifierProvider.value(
                value: diceModel,
                child: Consumer<DiceModel>(builder: (context, dice, _) {
                  return FractionallySizedBox(
                    widthFactor: 0.33,
                    child: Dice(
                      size: diceModel.size,
                      result: diceModel.result,
                      longPress: () => removeDice(
                        dice,
                        board,
                        Provider.of<ResultModel>(context, listen: false),
                      ),
                      onTap: () => reroll(
                        diceModel,
                        Provider.of<ResultModel>(context, listen: false),
                      ),
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class RerollBoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => rerollAll(
        Provider.of<BoardModel>(context, listen: false),
        Provider.of<ResultModel>(context, listen: false),
      ),
      tooltip: 'Reroll',
      child: Icon(Icons.autorenew),
    );
  }
}
