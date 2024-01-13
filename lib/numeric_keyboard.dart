library numeric_keyboard;
import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;


  NumericKeyboard(
      {Key? key,
        required this.onKeyboardTap,
        this.textColor = Colors.black,
        this.rightButtonFn,
        this.rightIcon,
        this.leftButtonFn,
        this.leftIcon,
        this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}