import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/views/chat/chat_view.dart';
import 'package:flutter_android_app/views/chat/dm.dart';
import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../screens/screens_page_view.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  int selected = 0;

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    ///users
    AppProvider UserViewProvider = Provider.of<AppProvider>(context);
    //

///////////////////////////////////////////////////////////////////////77
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
        body: Stack(
          children: [
            BackgroundContainer,
            StreamBuilder<List<ChatRooms>>(
                stream:
                    Provider.of<ChatroomViewModel>(context).getChatroomList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
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

                            return Column(
                              children: [
                                // if (index == 0)
                                //   Text(
                                //       '${data!.docs.first.data()['users'] ?? ""}'),
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
                                                    )));

                                        setState(() {
                                          selected = index;
                                          _visible = !_visible;
                                        });

                                        // Provider.of<ChatroomViewModel>(context,
                                        //         listen: false)
                                        //     .addNewChatroomUsers(
                                        //         chatRoomsName: chatRooms.name,
                                        //         chatRooms: chatRooms);
                                      },
                                      onTap: () {
                                        setState(() {
                                          selected = index;
                                          _visible = !_visible;
                                        });
                                      },
                                      child: Container(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                            '${chatRooms.flagImage}',
                                          )),
                                          title: Text('${chatRooms.name}'),
                                        ),
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
                                buildOnlineUsers(index, chatRooms, context,
                                    UserViewProvider.usersList),
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
      child: _visible && selected == index
          // && chatRooms.chatroomUsers.isNotEmpty

          /// selected ==index hangi butondaysa o nu çalışrma işini yapar
          /// _visible(false) ise butona tıklanmadan boş container döner. butonun içinde set state ile _visible =!_visible olduğu için butona tıklandığında true olur ve asıl alanı gösterir.
          ? Container(
              height: 200,
              child: ListView(
                  children: userList
                      .where((element) => element.id != data!.docs.first.id)
                      .map((user) => GestureDetector(
                            onDoubleTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dm(
                                          userId: user.id,
                                          userName: user.users,
                                          // user: user,
                                        ))),
                            child: ListTile(
                              title: Text('${user.users}'),
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ))
                      .toList()),
            )
          : Container(),
    );
  }
}
