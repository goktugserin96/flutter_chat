import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/page/verify_email_page.dart';

import 'auth_page.dart';

class MyHomePageAuth extends StatefulWidget {
  @override
  State<MyHomePageAuth> createState() => _MyHomePageAuthState();
}

class _MyHomePageAuthState extends State<MyHomePageAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return VerifyEmailPage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
