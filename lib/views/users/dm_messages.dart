import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/provider/app_provider.dart';
import 'package:flutter_android_app/views/chat/dm.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';

import '../../models/chat.dart';
import '../screens/screens_page_view.dart';

QuerySnapshot<Map<String, dynamic>>? dataChat;

class OnlineUsers extends StatefulWidget {
  @override
  State<OnlineUsers> createState() => _OnlineUsersState();
}

class _OnlineUsersState extends State<OnlineUsers> {
  void initState() {
    getData();

    super.initState();
  }

  bool isLoading = true;
  void getData() async {
    await FirebaseFirestore.instance
        .collection("chat")
        .orderBy(ChatInfoField.time, descending: true)
        .get()
        .then((value) {
      setState(() {
        dataChat = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AppProvider>(context).usersList;

    // var name = userProvider.map((e) => e.users).toString();
    // var id = userProvider.map((e) => e.id).toString();
    // print('dd $dd');

    final seen = Set<String>();
    var mix = dataChat!.docs
        .where((element) => element.data()['chatroomId'] == data!.docs.first.id
            ? seen.add(element.data()['receiverUser'])
            : element.data()['userId'] == data!.docs.first.id
                ? seen.add(element.data()['senderUser'])
                : false)
        .toList();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
          title:
              Center(child: Text('${data!.docs.first.data()['users'] ?? ""}')),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Stack(children: [
          BackgroundContainer,
          ListView.builder(
            itemCount: mix.length,
            itemBuilder: (context, index) {
              var chat = mix[index];

              var query1 = chat.data()['chatroomId'] == data!.docs.first.id;
              var query2 = chat.data()['userId'] == data!.docs.first.id;
              return messageList(context, chat, query1, query2);
            },
          )
        ]
            // children: dataChat!.docs
            //     .where((element) =>
            //         element.data()['userId'] == data!.docs.first.id ||
            //         element.data()['chatroomId'] == data!.docs.first.id)
            //     .where((element) =>
            //         seen.add(element.data()['receiverUser']) ||
            //         seen.add(element.data()['senderUser']))
            //     .map((e) {

            // }).toList()

            // print('ssssssss ${dataChat!.docs[index].data()["senderUser"]}');

            // print('ssssssss ${dataChat!.docs[index].data()["receiverUser"]}');
            // print('receiver ${users.receiverUser}');
            // print('---------------');
            // print('sender ${users.senderUser}');
            // print('---------------');

            //     children: unique
            //         // .where((chats) =>
            //         //     chats.userId == data!.docs.first.id ||
            //         //     chats.chatroomId == data!.docs.first.id)
            //         // .where((element) =>
            //         //     element.receiverUser == element.receiverUser ||
            //         //     element.senderUser == element.senderUser)
            //         // .toSet()
            //         // .toList()
            //         .map(
            //   (users) {
            //     return
            //     // : Container();
            //   },
            // ).toList()

            ));
  }

  Padding messageList(
      BuildContext context,
      QueryDocumentSnapshot<Map<String, dynamic>> chat,
      bool query1,
      bool query2) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dm(
                      userId: query1
                          ? chat.data()['userId']
                          : chat.data()['chatroomId'],
                      userName: query1
                          ? chat.data()['receiverUser']
                          : chat.data()['senderUser'])));
        },
        // ?
        //
        // : null,
        child: Container(
          color: Colors.white54.withOpacity(0.2),
          child: ListTile(
            trailing: query2
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  )
                : null,
            leading: Container(
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              width: 10,
              height: 10,
            ),
            title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                child: query1
                    ? Text('${chat.data()['receiverUser']}')
                    : Text('${chat.data()['senderUser']}')),
            subtitle: Text('${chat.data()['message']}'),
          ),
        ),
      ),
    );
  }
}
