import 'package:flutter/material.dart';

class Palette {
  Palette({this.seedColor, this.outlineColor});

  Color? seedColor;
  Color? outlineColor;
}

class DicerColors {
  static Palette palette = Palette(
    seedColor: Color.fromRGBO(2, 85, 121, 1),
    // primaryContainerColor: Color.fromRGBO(1, 2, 42, 1),
    outlineColor: Color.fromRGBO(255, 40, 109, 1),
    // secondaryContainerColor: Color.fromRGBO(2, 85, 121, 1),
  );
}
