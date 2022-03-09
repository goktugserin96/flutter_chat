import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view.dart';
import 'package:flutter_android_app/views/users/dm_messages.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../provider/app_provider.dart';
import '../users/users_view_model.dart';

String? errorPic =
    "https://img.wattpad.com/8f19b412f2223afe4288ed0904120a48b7a38ce1/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f5650722d38464e2d744a515349673d3d2d3234323931353831302e313434336539633161633764383437652e6a7067?s=fit&w=720&h=720";
QuerySnapshot<Map<String, dynamic>>? data;

class ScreensPage extends StatefulWidget {
  ScreensPage({Key? key, required this.pageIndex}) : super(key: key);

  int pageIndex;

  @override
  State<ScreensPage> createState() => _ScreensPageState();
}

class _ScreensPageState extends State<ScreensPage> {
  void initState() {
    getData();

    super.initState();
  }

  bool isLoading = true;
  void getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      if (!mounted) return;
      setState(() {
        data = value;
        isLoading = false;
      });
    });
  }

  int selectedIndex = 0;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      ChatroomPage(),
      DmMessages(),
    ];

    print('loading $isLoading');
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.7), //saydamlaştırma
        selectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: widget.pageIndex,
        onTap: (index) {
          setState(() {
            widget.pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Chatrooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          )
        ],
      ),
      //
      body: StreamBuilder<List<Users>>(
        stream: UserViewModel.getUsersList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('dfdfd${snapshot.data}');
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()),
            );
          } else {
            List<Users> userList = snapshot.data!;

            Provider.of<AppProvider>(context).setUsers(userList);
            return tabs[widget.pageIndex];
          }
        },
      ),
    );
  }
}
