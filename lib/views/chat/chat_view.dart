import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:flutter_android_app/views/screens/screens_page_view.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';
import 'package:provider/provider.dart';

import 'chat_view_model.dart';

class ChatPage extends StatefulWidget {
  final ChatRooms chatRooms;
  final Users user;

  const ChatPage({
    Key? key,
    required this.chatRooms,
    required this.user,

    // required this.online
  }) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    UserViewModel UserViewProvider = Provider.of<UserViewModel>(context);

    List<Users> UserProvider = UserViewProvider.usersList;

    ///chats
    ChatViewModel ChatViewModelProvider = Provider.of<ChatViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await Provider.of<ChatroomViewModel>(context, listen: false)
                  .deleteUser(widget.user);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          centerTitle: true,
          title: Text('${widget.chatRooms.name}'),
        ),
        body: Stack(
          children: [
            BackgroundContainer(),
            StreamBuilder<List<ChatInfo>>(
                stream: ChatViewModelProvider.getChatList(widget.chatRooms.id),
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
                    //  userList.add(chatInfoUser!.user);
                    print('uzunluk ${chatList!.length}');
                    // print('kelime sayısı ${charLength}');
                    // print(
                    //     'ChatViewModelProvider ${ChatViewModelProvider.chatInfoList.length}');
                    return Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  // shrinkWrap: true,
                                  // physics: BouncingScrollPhysics(),
                                  itemCount: chatList.length,
                                  itemBuilder: (context, index) {
                                    ChatInfo chat = chatList[index];

                                    return buildChatArea(chat);
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
                            child: buildTextField(
                                ChatViewModelProvider, UserProvider),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ));
  }

  Card buildChatArea(ChatInfo chat) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.deepPurpleAccent,
      child: ListTile(
        leading: Text('${chat.user}:'),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: Text('${chat.message}'),
        ),
      ),
    );
  }

  Widget buildTextField(
    ChatViewModel ChatViewModelProvider,
    List<Users> UserProvider,
  ) {
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
                        ChatViewModelProvider.addNewChat(
                          user: UserProvider[0].users,
                          message: _controller.text,
                          chatRoomsId: widget.chatRooms.id,
                          //   users: UserProvider,
                          userId: widget.user.id,
                        );

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
