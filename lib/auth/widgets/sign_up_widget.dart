import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/provider/email_sign_in.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:provider/provider.dart';

import '../../views/users/users_view_model.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key, required this.onClickedSignIn})
      : super(key: key);
  final Function() onClickedSignIn;

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _registerFormKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _registerEmail = TextEditingController();
  TextEditingController _registerSifre = TextEditingController();
  TextEditingController _registerSifreOnay = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register Screen",
                style: TextStyle(fontSize: 30),
              ),
              Form(
                key: _registerFormKey,
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.only(top: 15),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _userName,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.people),
                              hintText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _registerEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? "Enter a valid email"
                                  : null,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(Icons.email),
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _registerSifre,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) =>
                              password != null && password.length < 6
                                  ? "Enter min. 6 characters"
                                  : null,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _registerSifreOnay,
                          validator: (sifreOnayReg) {
                            if (sifreOnayReg != _registerSifre.text) {
                              return "şifreler aynı olmak zorundadır";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Repeat Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                //  _registerFormKey.currentState!.validate() bu şart hataların çıkması için (Eğer bütün form elemanları email geçerliyse şifre 6 harfli olmasına okey verdiyse alttakileri çalıştır.),
                                await _showMyDialog;
                                final create = await Provider.of<
                                        EmailSignInProvider>(context,
                                    // eğer bilgiler doğruysa kullanıcının verdiği bilgiler ile bir user elde edelim.
                                    listen: false);
                                create.createUserWithEmailAndPassword(
                                    _registerEmail.text.trim(),
                                    _registerSifre.text.trim());

                                final newUser = Users(
                                    users: _userName.text.trim(),
                                    email: _registerEmail.text.trim());

                                UserViewModel.addNewUser(
                                    users: newUser, isOnline: false);

                                // print("user $user");

                                // if (user != null && !user.emailVerified) {
                                //   //bu kullaıcının maili verified değilse,
                                //   // kullanıcı direk istediği maili yazıp kayıt olabiliyorr bunu engellemek için yazdık. mail gönderiyor.
                                //   await user.sendEmailVerification();
                                // }

                                //  showSnackBar("Sended an e mail please verify ");
                                // Provider.of<Auth>(context, listen: false).SignOut();

                                // setState(() {
                                //   _formStatus = FormStatus.signIn;
                                // });
                              }
                            },
                            child: Text("Register")),
                        SizedBox(
                          height: 40,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Already have you account?  ",
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignIn,
                                  text: "Login",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue))
                            ])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => Center(
              child: CircularProgressIndicator(),
            ));
  }

  Future<void> _showmydialogdeneme(String errorText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata oluştu'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
