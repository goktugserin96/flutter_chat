import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/views/chat/dm.dart';

import '../../data.dart';
import '../../models/chat.dart';
import '../screens/screens_page_view.dart';

QuerySnapshot<Map<String, dynamic>>? dataChat;

class DmMessages extends StatefulWidget {
  @override
  State<DmMessages> createState() => _DmMessagesState();
}

class _DmMessagesState extends State<DmMessages> {
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

  List<QueryDocumentSnapshot<Map<String, dynamic>>> mix = [];
  @override
  Widget build(BuildContext context) {
    final seen = Set<String>();

    if (isLoading == false) {
      mix = dataChat!.docs
          .where((element) => element.data()['chatroomId'] ==
                  data!.docs.first
                      .id //chatroomId eğer bana eşitse mesajı be göndermiş oluyorum mesajı gönderdiğim kişinin adını set<string> e ekledik

              ? seen.add(element.data()['receiverUser'])
              : element.data()['userId'] == data!.docs.first.id
                  ? seen.add(element.data()['senderUser'])
                  : false)
          .toList();
    }

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
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : dataChat!.docs.isEmpty
                  ? Center(
                      child: Text('There is no any message'),
                    )
                  : ListView.builder(
                      itemCount: mix.length,
                      itemBuilder: (context, index) {
                        var chat = mix[index];

                        // final isMe = chat. == widget.userId &&
                        //     chat.chatroomId == data!.docs.first.id;

                        /// userId ==data!.docs.first.id =>gelen mesaj
                        ///chatroomId ==data!.docs.first.id => giden mesaj
                        ///
                        /// Query1 giden mesaj
                        /// Query2 gelen mesaj

                        print('deneme ${chat.data()['userId']}');
                        print('deneme2 ${chat.data()['chatroomId']}');

                        var query1 =
                            chat.data()['chatroomId'] == data!.docs.first.id;
                        var query2 =
                            chat.data()['userId'] == data!.docs.first.id;
                        var isChatroom = chat.data()['senderUser'] !=
                            chat.data()['receiverUser'];

                        return messageList(
                            context, chat, query1, query2, isChatroom);
                      },
                    )
        ]));
  }

  Padding messageList(
      BuildContext context,
      QueryDocumentSnapshot<Map<String, dynamic>> chat,
      bool query1,
      bool query2,
      bool isChatroom) {
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
            child: isChatroom
                ? ListTile(
                    trailing: query2
                        ? CircleAvatar(
                            child: Text(
                              "1",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            radius: 10,
                          )
                        : null,
                    title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                        child: query1 & isChatroom
                            ? Text('${chat.data()['receiverUser']}')
                            : Text('${chat.data()['senderUser']}')),
                    subtitle: Text('${chat.data()['message']}'))
                : null),
      ),
    );
  }
}
