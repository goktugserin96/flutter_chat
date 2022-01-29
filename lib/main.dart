import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/views/chat/chat_view_model.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';
import 'package:provider/provider.dart';

import 'auth/provider/email_sign_in.dart';
import 'auth/provider/google_sign_in.dart';
import 'auth/util/utils.dart';

// const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
const AssetImage assetImage = AssetImage("assets/images/background.png");

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  //
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.signInAnonymously().hashCode);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ChatroomViewModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ChatViewModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => EmailSignInProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        theme: ThemeData.dark(),
        //.copyWith(scaffoldBackgroundColor: darkBlue),
        home: NickNamePage(),
      ),
    );
  }
}

//
