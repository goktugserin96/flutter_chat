import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/auth/page/forgot_password_page.dart';
import 'package:flutter_android_app/auth/provider/email_sign_in.dart';
import 'package:flutter_android_app/auth/provider/google_sign_in.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:provider/provider.dart';

import 'my_elevated_button.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  final VoidCallback onClickedSignUp;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController _signInEmail = TextEditingController();
  TextEditingController _signInPassword = TextEditingController();

  @override
  void dispose() {
    _signInEmail.dispose();
    _signInPassword.dispose();
    super.dispose();
  }

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
              const FlutterLogo(
                size: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hey There, Welcome",
                style: TextStyle(fontSize: 26),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please Enter Your Email And Password",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _signInFormKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _signInEmail,
                          validator: (email) {
                            if (!EmailValidator.validate(email!)) {
                              return 'Lütfen geçerli bir adres giriniz';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "E-mail",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _signInPassword,
                          validator: (sifre) {
                            if (sifre!.length < 6) {
                              return "Lütfen en az 6 karakterli bir şifre girniz";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_signInFormKey.currentState!.validate()) {
                                  //  _registerFormKey.currentState!.validate() bu şart hataların çıkması için (Eğer bütün form elemanları email geçerliyse şifre 6 harfli olmasına okey verdiyse alttakileri çalıştır.),
                                  await _showMyDialog;
                                  final signIn = await Provider.of<
                                          EmailSignInProvider>(
                                      context, // eğer bilgiler doğruysa kullanıcının verdiği bilgiler ile bir user elde edelim.
                                      listen: false);

                                  signIn.SignInWithEmailAndPassword(
                                      _signInEmail.text.trim(),
                                      _signInPassword.text.trim());

                                  // if (!user!.emailVerified) {
                                  //   //bu kullaıcının maili verified değilse,
                                  //   // kullanıcı direk istediği maili yazıp kayıt olabiliyorr bunu engellemek için yazdık. mail gönderiyor.
                                  //
                                  //   await _showMyDialog();
                                  //   //  await Provider.of<EmailSignInProvider>(context, listen: false).SignOutt();
                                  // }
                                  // Navigator.pop(context);
                                }
                              },
                              child: Text("Sign In")),
                        ),
                        // TextButton(
                        //     onPressed: () {
                        //       setState(() {
                        //         _formStatus = FormStatus.register;
                        //       });
                        //     },
                        //     child: Text("Yeni Kayıt için Tıklayınız")),
                        GestureDetector(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage())),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: "No account?  ",
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: "Create New Account",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue))
                            ])),

                        // TextButton(
                        //     onPressed: () {
                        //       setState(() {
                        //         _formStatus = FormStatus.reset;
                        //       });
                        //     },
                        //     child: Text("Şifremi Unuttum")),

                        // ElevatedButton.icon(
                        //   onPressed: () {
                        //     Provider.of<GoogleSignInProvider>(context, listen: false)
                        //         .signInWithGoogle();
                        //   },
                        //   label: Text("Sign up with Google"),
                        //   style: ElevatedButton.styleFrom(
                        //       elevation: 10,
                        //       primary: Colors.white,
                        //       onPrimary: Colors.black,
                        //       maximumSize: Size(double.infinity, 50)),
                        //   icon: FaIcon(
                        //     FontAwesomeIcons.google,
                        //     color: Colors.red,
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        MyElevatedButton(
                          title: "Login with Google",
                          onPressed: elevatedButton,
                          buttonName: Buttons.GoogleDark,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // SizedBox(
      //   height: 40,
      // ),
      // RichText(
      //     text: TextSpan(text: 'Already have you account? ', children: [
      //   TextSpan(
      //       text: 'Log in',
      //       style: TextStyle(decoration: TextDecoration.underline))
      // ])),
      // Spacer(),
    );
  }

  Future elevatedButton() async {
    Provider.of<GoogleSignInProvider>(context, listen: false)
        .signInWithGoogle();
  }
  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Onay Gerekiyor'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text('Merhaba Lütfen Mailinizi Kontrol Ediniz'),
  //               Text('Onay Linkine Tıklayıp tekrar giriş yapmalısınız'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Anladım'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => Center(
              child: CircularProgressIndicator(),
            ));
  }
}
