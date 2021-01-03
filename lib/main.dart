import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_action_row/floating_action_row.dart';

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
      floatingActionButton: RerollBoardButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
    return FloatingActionRow(
      color: Colors.amber,
      axis: Axis.vertical,
      children: [
        FloatingActionRowButton(
          icon: Icon(Icons.add),
          onTap: () => showModalBottomSheet(
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
        FloatingActionRowDivider(),
        FloatingActionRowButton(
          icon: Icon(Icons.autorenew),
          onTap: () => rerollAll(
            Provider.of<BoardModel>(context, listen: false),
            Provider.of<ResultModel>(context, listen: false),
          ),
        ),
      ],
    );
  }
}
