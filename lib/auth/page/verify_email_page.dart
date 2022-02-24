import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/provider/email_sign_in.dart';
import 'package:flutter_android_app/views/screens/screens_page_view.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? timer;
  bool isEmailVerify = false;
  bool canResendEmail = true;

  @override
  void initState() {
    final sendVerificationEmail =
        Provider.of<EmailSignInProvider>(context, listen: false);
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    // print(
    //     "FirebaseAuth.instance.currentUser!.emailVerified ${FirebaseAuth.instance.currentUser!.emailVerified}");
    // print("isEmailVerify ${isEmailVerify}");

    ///if it is not email verify then send verification email
    if (!isEmailVerify) {
      sendVerificationEmail.SendVerificationEmail();

      ///every 3 second execute checkEmailVerified method and this will reload the page  if user click verification code
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// first, current user reload, FirebaseAuth.instance.currentUser!.emailVerified is going to be true
  /// we assign it to isEmailVerify and this is going to be true
  /// lastly, timer will be close because isEmailVerify is true
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      myData = FirebaseAuth.instance.currentUser!;
    });
    if (isEmailVerify) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // var sendVerificationEmail =
    //     Provider.of<EmailSignInProvider>(context, listen: false)
    //         .SendVerificationEmail();

    myData = FirebaseAuth.instance.currentUser!;
    return isEmailVerify
        ? ScreensPage(mail: myData!.email!)
        : Scaffold(
            appBar: AppBar(
              title: Text("Verify Email"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A verification email has been sent to your email ",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    // style: ElevatedButton.styleFrom(
                    //     minimumSize: Size.fromHeight(50)),
                    onPressed: canResendEmail ? SendVerificationEmail : null,
                    icon: Icon(
                      Icons.email,
                      size: 30,
                    ),
                    label: Text(
                      "Resent Email",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(15)),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: Text(
                        "Go Back",
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            ),
          );
  }

  Future SendVerificationEmail() async {
    setState(() => canResendEmail = false);
    await Future.delayed(Duration(seconds: 5));
    setState(() => canResendEmail = true);

    Provider.of<EmailSignInProvider>(context, listen: false)
        .SendVerificationEmail();
  }
}
