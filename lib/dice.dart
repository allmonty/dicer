import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dice extends StatelessWidget {
  const Dice({
    Key? key,
    this.size,
    this.result,
    this.padding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    this.foregroundColor,
    this.backgroundColor,
    this.outlineColor,
    this.onTap,
    this.longPress,
  }) : super(key: key);

  final int? size;
  final int? result;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final VoidCallback? onTap;
  final VoidCallback? longPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        splashColor: foregroundColor,
        onTap: onTap,
        onLongPress: longPress,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: padding,
            child: Column(
              children: <Widget>[
                Text(
                  'D$size',
                  style: TextStyle(fontFamily: GoogleFonts.revalia().fontFamily, color: foregroundColor),
                ),
                Divider(color: outlineColor, thickness: 3),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '${result! > 0 ? result : "-"}',
                      style: TextStyle(fontFamily: GoogleFonts.revalia().fontFamily, color: foregroundColor),
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
