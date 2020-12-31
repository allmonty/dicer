import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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
  int d20aResult = 10;
  int d20bResult = 10;

  void changeD20aResult() {
    setState(() {
      this.d20aResult = 1 + Random().nextInt(19);
    });
  }

  void changeD20bResult() {
    setState(() {
      this.d20bResult = 1 + Random().nextInt(5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.blueGrey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: changeD20aResult,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: Text('D20'),
                    ),
                    Text(
                      '${this.d20aResult}',
                      style: TextStyle(fontSize: 48),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.blueGrey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: changeD20bResult,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: Text('D6'),
                    ),
                    Text(
                      '${this.d20bResult}',
                      style: TextStyle(fontSize: 48),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Text(
            "Total: ${this.d20aResult + this.d20bResult}",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeD20aResult();
          changeD20bResult();
        },
        tooltip: 'Increment',
        child: Icon(Icons.autorenew),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
