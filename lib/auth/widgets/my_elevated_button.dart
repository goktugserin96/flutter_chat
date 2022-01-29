import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class MyElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Buttons buttonName;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 45,
        child: SignInButton(
          buttonName,
          text: title,
          onPressed: onPressed,
          elevation: 7,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}
