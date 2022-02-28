import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/provider/app_provider.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';

import '../screens/screens_page_view.dart';
import 'chat_view_model.dart';

class Dm extends StatefulWidget {
  // final Users user;
  final String userId;
  final String userName;

  const Dm({
    Key? key,
    // required this.user,
    required this.userId,
    required this.userName,

    // required this.online
  }) : super(key: key);
  @override
  State<Dm> createState() => _DmState();
}

class _DmState extends State<Dm> {
  QuerySnapshot<Map<String, dynamic>>? chatData;

  void getData() async {
    await FirebaseFirestore.instance
        .collection('chat')
        .where('chatroomId', isEqualTo: widget.userId)
        .where('userId', isEqualTo: data!.docs.first.id)
        .get()
        .then((value) => chatData = value);
  }

  int charLength = 0;

  bool status = false;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });

    if (charLength >= 1) {
      setState(() {
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('${widget.usersList.length}');

    ///users
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              // await Provider.of<ChatroomViewModel>(context, listen: false)
              //     .deleteUser(widget.user);

              Navigator.pop(context);

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          centerTitle: true,
          title: Text('${widget.userName}'),
        ),
        body: Stack(
          children: [
            BackgroundContainer,
            StreamBuilder<List<ChatInfo>>(
                stream: ChatViewModel.getPrivateChatList(
                    data!.docs.first.id, widget.userId), //UserProvider[0].id
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('dfdfd${snapshot.data}');
                    return Center(child: Text('${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    List<ChatInfo>? chatList = snapshot.data;

                    Provider.of<AppProvider>(context).setChats(chatList!);

                    return Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  // shrinkWrap: true,
                                  // physics: BouncingScrollPhysics(),
                                  itemCount: chatList.length,
                                  itemBuilder: (context, i) {
                                    ChatInfo chat = chatList[i];
                                    // Provider.of<AppProvider>(context)
                                    //     .deneme(chat);

                                    final isMe = chat.userId == widget.userId &&
                                        chat.chatroomId == data!.docs.first.id;

                                    final deneme1 =
                                        chat.chatroomId == data!.docs.first.id;

                                    final deneme2 =
                                        chat.userId == widget.userId;

                                    final deneme3 =
                                        chat.chatroomId == widget.userId;

                                    final deneme4 =
                                        chat.userId == data!.docs.first.id;

                                    return
                                        // chatBuild(chat,isMe,deneme1,deneme2,deneme3,deneme4)
                                        //
                                        //
                                        // (deneme1 && deneme2) ||
                                        //       (deneme3 && deneme4)
                                        //   ? DmChatWidget(isMe: isMe, chat: chat)
                                        //   : Container();

                                        buildChatArea(chat, isMe, deneme1,
                                            deneme2, deneme3, deneme4);
                                  }),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 18, 32, 47),
                                  // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: buildTextField(appProvider, chatList),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ));
  }

  Widget buildChatArea(
      ChatInfo chat, bool isMe, bool deneme1, bool deneme2, deneme3, deneme4) {
    return (deneme1 && deneme2) || (deneme3 && deneme4)
        ? Bubble(
            margin: const BubbleEdges.only(top: 10),
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            nipWidth: 6,
            nipHeight: 5,
            nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
            color: isMe ? Colors.green : Colors.amberAccent,
            child: Text(
              '${chat.message}',
            ),
          )
        : Container();
  }

  Widget buildTextField(
      AppProvider ChatViewModelProvider, List<ChatInfo> chatList) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _onChanged,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _controller,
                decoration: InputDecoration(
                  fillColor: Colors.black45,
                  filled: true,
                  hintText: "Send Message ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: status,
            child: status
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 7,
                          primary: Colors.deepPurpleAccent,
                          fixedSize: Size(20, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        status = false;

                        ///chat provider database için // chati burada atama yapıyoruz
                        ///
                        ///
                        ///
                        final newChat = ChatInfo(
                            chatroomId: data!.docs.first.id,
                            senderUser: data!.docs.first.data()['users'] ?? "",
                            receiverUser: widget.userName,
                            message: _controller.text,
                            time: DateTime.now(),
                            userId: widget.userId);
                        ChatViewModelProvider.createChat(newChat);

                        // ChatViewModelProvider.updateUsersIsOnline(
                        //     widget.user, widget.user.id, chatList);

                        _controller.clear();
                      },
                      child: Icon(Icons.send),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
