import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dice.dart';
import 'add_dice_form.dart';
import 'utils/floating_modal_bottom_sheet.dart';
import 'utils/dicer_colors.dart';
import 'models/result_model.dart';
import 'models/board_model.dart';
import 'models/dice_model.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DICER',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DicerColors.palette.seedColor!,
          outline: DicerColors.palette.outlineColor!,
          brightness: Brightness.dark,
        ),
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
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Container(
          margin: EdgeInsets.only(bottom: 13, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("DICER"),
              Image(image: AssetImage('assets/icon.png'), height: 50),
              BoardResult(),
            ],
          ),
        ),
        shape: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outline, width: 3)),
      ),
      body: Center(child: DicesBoard()),
      floatingActionButton: BoardButtons(),
    );
  }
}

void rerollAll(BoardModel board, ResultModel result) {
  for (var element in board.items) {
    element.roll();
  }
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
  const BoardResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Σ ${Provider.of<ResultModel>(context).result}");
  }
}

class DicesBoard extends StatelessWidget {
  const DicesBoard({super.key});

  @override
  Widget build(BuildContext context, {Key? key, Color? backgroundColor}) {
    return Consumer<BoardModel>(
      builder: (context, board, _) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: board.items.map((diceModel) {
              return ChangeNotifierProvider.value(
                value: diceModel,
                child: Consumer<DiceModel>(
                  builder: (context, dice, _) {
                    return FractionallySizedBox(
                      widthFactor: 0.33,
                      child: Dice(
                        size: diceModel.size,
                        result: diceModel.result,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        outlineColor: Theme.of(context).colorScheme.outline,
                        longPress: () => removeDice(dice, board, Provider.of<ResultModel>(context, listen: false)),
                        onTap: () => reroll(diceModel, Provider.of<ResultModel>(context, listen: false)),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class BoardButtons extends StatelessWidget {
  const BoardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          foregroundColor: Theme.of(context).colorScheme.outline,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return FloatingModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                topBorderColor: Theme.of(context).colorScheme.outline,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: AddDiceForm(add: Provider.of<BoardModel>(context, listen: false).add),
              );
            },
          ),
          child: Icon(Icons.add),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          foregroundColor: Theme.of(context).colorScheme.outline,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(Icons.autorenew),
          onPressed: () => rerollAll(
            Provider.of<BoardModel>(context, listen: false),
            Provider.of<ResultModel>(context, listen: false),
          ),
        ),
      ],
    );
  }
}
