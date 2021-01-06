import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dice extends StatelessWidget {
  const Dice({Key key, this.size, this.result, this.onTap, this.longPress})
      : super(key: key);

  final int size;
  final int result;
  final Function onTap;
  final Function longPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).dialogBackgroundColor,
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: onTap,
        onLongPress: longPress,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: <Widget>[
                Text('D$size'),
                Divider(
                  color: Theme.of(context).accentColor,
                  thickness: 3,
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '${result > 0 ? result : "-"}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.revalia().fontFamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
