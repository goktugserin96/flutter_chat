import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/views/chat/chat_view.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';
import 'package:provider/provider.dart';

class chatroomPage extends StatefulWidget {
  //final String name;
  const chatroomPage({
    Key? key,
    //  required this.name,
  }) : super(key: key);

  @override
  State<chatroomPage> createState() => _chatroomPageState();
}

class _chatroomPageState extends State<chatroomPage> {
  List<String> rooms = ['Chat Room1', 'Chat Room2 ', 'Chat Room3'];

  // List<String> chats = [
  //   'Main Room Chat ',
  //   'Chat Room1 Chat',
  //   'Chat Room2 Chat ',
  //   'Chat Room3 Chat'
  // ];

  // @override
  // void initState() {
  //   for (int i = 0; i < rooms.length; i++) {
  //     Provider.of<ChatroomViewModel>(context, listen: false)
  //         .addNewChatroom(roomName: rooms[i]);
  //   }
  // }

  int selected = 0;

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    ///users
    UserViewModel UserViewProvider = Provider.of<UserViewModel>(context);

    List<Users> UserProvider = UserViewProvider.usersList;
///////////////////////////////////////////////////////////////////////77

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundContainer(),
            StreamBuilder<List<ChatRooms>>(
                stream:
                    Provider.of<ChatroomViewModel>(context).getChatroomList(),
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
                    List<ChatRooms> chatRoomList = snapshot.data!;

                    return Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatRoomList.length,
                          itemBuilder: (context, index) {
                            ChatRooms chatRooms = chatRoomList[index];

                            List<Users> userList = chatRooms.chatroomUsers;

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                    chatRooms: chatRooms,
                                                    user: userList[index])));

                                        setState(() {
                                          selected = index;
                                          _visible = !_visible;
                                        });

                                        userList.add(UserProvider[0]);

                                        Provider.of<ChatroomViewModel>(context,
                                                listen: false)
                                            .addNewChatroomUsers(
                                                chatRoomsName: chatRooms.name,
                                                userList: userList,
                                                chatRooms: chatRooms);
                                      },
                                      onTap: () {
                                        setState(() {
                                          selected = index;
                                          _visible = !_visible;
                                        });
                                      },
                                      child: Container(
                                        child:
                                            Center(child: Text(chatRooms.name)),
                                        decoration: BoxDecoration(
                                          color: selected == index
                                              ? Colors.orange
                                              : Colors.deepPurpleAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                buildOnlineUsers(
                                    index, chatRooms, context, userList),
                              ],
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget buildOnlineUsers(int index, ChatRooms chatRooms, BuildContext context,
      List<Users> userList) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: _visible,
      child: _visible && selected == index && chatRooms.chatroomUsers.isNotEmpty

          /// selected ==index hangi butondaysa o nu çalışrma işini yapar
          /// _visible(false) ise butona tıklanmadan boş container döner. butonun içinde set state ile _visible =!_visible olduğu için butona tıklandığında true olur ve asıl alanı gösterir.
          ? Container(
              color: Colors.transparent,
              width: double.infinity,
              height: 200,
              child: Column(
                children: userList.map((element) {
                  final name = element.users;
                  return Expanded(
                    child: ListTile(
                      title: Text(name),
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        width: 10,
                        height: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : Container(),
    );
  }
}
