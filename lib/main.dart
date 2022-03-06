import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/provider/app_provider.dart';
import 'package:flutter_android_app/services/chatroom_database.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
import 'package:provider/provider.dart';

import 'auth/page/home_page.dart';
import 'auth/provider/email_sign_in.dart';
import 'auth/provider/google_sign_in.dart';
import 'auth/util/utils.dart';
import 'data.dart';

// const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

User? myData;
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
  await ChatroomDatabase.addChatRoomsCountries(chatroomsList);
  // await ChatDatabase.addChatInitial(chatList);
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';
  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.signInAnonymously().hashCode);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AppProvider(),
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => ChatroomViewModel()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => EmailSignInProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        theme: ThemeData.dark(),
        home:
            //ExitPage()
            MyHomePageAuth(),
      ),
    );
  }
}

//
