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
        extendBody: true,
        appBar: AppBar(
          title: BoardResult(),
        ),
        body: Center(
          child: Column(children: [Lala(), DicesBoard()]),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: AddDice(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: RerollBoardButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class AddDice extends StatelessWidget {
  const AddDice({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0),
          child: null,
        ),
      ),
    );
  }
}

class Lala extends StatelessWidget {
  const Lala({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child:
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     TextFormField(
          //       initialValue: '6',
          //       decoration: InputDecoration(icon: Text("D")),
          //       keyboardType: TextInputType.number,
          //     ),
          //     TextFormField(
          //       initialValue: '1',
          //       decoration: InputDecoration(icon: Text("#")),
          //       keyboardType: TextInputType.number,
          //     ),
          //   ],
          // ),
          Text("add", style: TextStyle(fontSize: 20)),
        ),
        // RaisedButton(
        Text("add", style: TextStyle(fontSize: 20)),
        // onPressed: (){},
        // )
      ],
    ),);
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
