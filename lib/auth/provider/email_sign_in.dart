import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/util/utils.dart';

import '../../main.dart';

class EmailSignInProvider extends ChangeNotifier {
  /////////
  ////////

  Future<User?> SignInWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, true);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // final userCredentials =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, true);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> ResetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Utils.showSnackBar("Password Reset Email Sent", false);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, true);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future SendVerificationEmail() async {
    try {
      final user = await FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      Utils.showSnackBar("Check your Email", false);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, true);
    }
  }

  // Future<void> SignOutt() async {
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class Auth {
//   final _firebaseAuth = FirebaseAuth.instance;
//
//   Future<User?> createUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final userCredentials = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//
//       return userCredentials.user;
//     } on FirebaseAuthException catch (e) {
//       print(e.code);
//       print(e.message);
//       rethrow;
//     }
//
//     //
//   }
//
//   Future<User?> SignInWithEmailAndPassword(
//       String email, String password) async {
//     final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return userCredentials.user;
//   }
//
//   Future<void> ResetPassword(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }
//
//   Future<User?> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     UserCredential userCredential =
//         await _firebaseAuth.signInWithCredential(credential);
//     return userCredential.user;
//   }
//

//
//   // Stream<User?> authStatus() {
//   //   return _firebaseAuth.authStateChanges();
//   // }
// }
