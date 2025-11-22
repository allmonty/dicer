import 'package:flutter/material.dart';

class FloatingModalBottomSheet extends StatelessWidget {
  const FloatingModalBottomSheet({
    Key? key,
    this.child,
    this.backgroundColor,
    this.topBorderColor,
    this.padding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  }) : super(key: key);

  final Widget? child;
  final Color? backgroundColor;
  final Color? topBorderColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(padding: padding, child: child),
        decoration: BoxDecoration(
          color: backgroundColor!,
          border: Border(top: BorderSide(color: topBorderColor!, width: 3)),
        ),
      ),
    );
  }
}
