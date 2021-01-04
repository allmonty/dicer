import 'package:flutter/material.dart';

class Palette {
  Palette(this.primaryColor, this.backgroundColor, this.dialogBackgroundColor,
      this.accentColor);

  Color primaryColor;
  Color backgroundColor;
  Color dialogBackgroundColor;
  Color accentColor;
}

class DicerColors {
  static Palette palette = palette2;

  // static Palette palette1 = Palette(
  //     Color.fromRGBO(110, 27, 141, 1),
  //     Color.fromRGBO(10, 23, 49, 1),
  //     Color.fromRGBO(18, 60, 120, 1),
  //     Color.fromRGBO(227, 1, 209, 1));

  static Palette palette2 = Palette(
      Color.fromRGBO(2, 85, 121, 1),
      Color.fromRGBO(1, 2, 42, 1),
      Color.fromRGBO(2, 85, 121, 1),
      Color.fromRGBO(255, 40, 109, 1));
}
