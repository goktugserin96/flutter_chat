import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view.dart';
import 'package:flutter_android_app/views/users/online_users.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          chatroomPage(),
          OnlineUsers(),
        ],
      ),
    );
  }
}
