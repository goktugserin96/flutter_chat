import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, bool error) {
    if (text == null) return;
    final snackBar = SnackBar(
        content: Text(text),
        backgroundColor: error ? Colors.red : Colors.green);

    scaffoldMessengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
