import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/widgets/login_widget.dart';
import 'package:flutter_android_app/auth/widgets/sign_up_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: isLogin
            ? LoginWidget(onClickedSignUp: toggle)
            : SignUpWidget(onClickedSignIn: toggle),
      );

  void toggle() => setState(() => isLogin = !isLogin);
}
