// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_android_app/models/chat.dart';
// import 'package:flutter_android_app/models/chat_rooms.dart';
// import 'package:flutter_android_app/models/users.dart';
// import 'package:flutter_android_app/util/chatroom.dart';
// import 'package:flutter_android_app/views/chat_rooms/chatroom_view_model.dart';
// import 'package:flutter_android_app/views/nickname/nickname_view.dart';
// import 'package:flutter_android_app/views/users/users_view_model.dart';
// import 'package:provider/provider.dart';
//
// class chatroomPage2 extends StatefulWidget {
//   //final String name;
//   const chatroomPage2({
//     Key? key,
//     //  required this.name,
//   }) : super(key: key);
//
//   @override
//   State<chatroomPage2> createState() => _chatroomPage2State();
// }
//
// class _chatroomPage2State extends State<chatroomPage2> {
//   ChatRoomType selectedRoom = ChatRoomType.room1;
//   List<String> rooms = [
//     'Main Room ',
//     'Chat Room1',
//     'Chat Room2 ',
//     'Chat Room3'
//   ];
//
//   List<String> chats = [
//     'Main Room Chat ',
//     'Chat Room1 Chat',
//     'Chat Room2 Chat ',
//     'Chat Room3 Chat'
//   ];
//
//   // @override
//   // void initState() {
//   //   for (int i = 0; i < rooms.length; i++) {
//   //     Provider.of<ChatroomViewModel>(context, listen: false)
//   //         .addNewChatroom(roomName: rooms[i]);
//   //   }
//   // }
//
//   int selected = 0;
//
//   bool _visible = false;
//
//   int counter = 0;
//   ChatInfo? chatInfoDatas;
//   @override
//   Widget build(BuildContext context) {
//     ///users
//     UserViewModel UserViewProvider = Provider.of<UserViewModel>(context);
//
//     List<Users> UserProvider = UserViewProvider.usersList;
// ///////////////////////////////////////////////////////////////////////77
//
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             BackgroundContainer(),
//             StreamBuilder<List<ChatRooms>>(
//                 stream:
//                     Provider.of<ChatroomViewModel>(context).getChatroomList(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     print('dfdfd${snapshot.data}');
//                     return Center(child: Text('${snapshot.error}'));
//                   } else if (!snapshot.hasData) {
//                     return const Center(
//                       child: SizedBox(
//                         width: 50,
//                         height: 50,
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   } else {
//                     List<ChatRooms> chatRoomList = snapshot.data!;
//
//                     // print('user provider ${UserViewProvider.usersList.length}');
//                     //   print('chat provider ${chatInfoProvider.length}');
//
//                     return Container(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               child: ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: chatRoomList.length,
//                                   itemBuilder: (context, index) {
//                                     ChatRooms chatRooms = chatRoomList[index];
//
//                                     // List<Users> userList =
//                                     //     chatRooms.chatroomUsers;
//
//                                     // List<ChatInfo> chatInfoList =
//                                     //     chatRooms.chatOfChatroom;
//                                     // print(
//                                     //     "chatInfoList sayısı ${chatInfoList.length}");
//                                     // FirebaseFirestore.instance
//                                     //     .collection('chatroom')
//                                     //     .doc(chatRooms.id)
//                                     //     .update({
//                                     //   "chatroomUsers": FieldValue.arrayUnion(userList)
//
//                                     return Column(
//                                       children: [
//                                         Column(
//                                           children:
//                                               ChatRoomType.values.map((type) {
//                                             final name = getChatRoomType(type);
//
//                                             return Expanded(
//                                               child: Center(
//                                                 child: GestureDetector(
//                                                   onDoubleTap: () {
//                                                     setState(() {
//                                                       selectedRoom = type;
//                                                       _visible = !_visible;
//                                                     });
//
//                                                     // userList
//                                                     //     .add(UserProvider[0]);
//
//                                                     Provider.of<ChatroomViewModel>(
//                                                             context,
//                                                             listen: false)
//                                                         .addNewChatroomUsers(
//                                                       chatRooms: name,
//                                                       //    usersList: userList,
//                                                     );
//                                                   },
//                                                   onTap: () {
//                                                     setState(() {
//                                                       selectedRoom = type;
//                                                       _visible = !_visible;
//                                                     });
//                                                   },
//                                                   child: Container(
//                                                     child: Center(
//                                                         child: Text('${name}')),
//                                                     decoration: BoxDecoration(
//                                                       color: selectedRoom ==
//                                                               type
//                                                           ? Colors.orange
//                                                           : Colors
//                                                               .deepPurpleAccent,
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   10.0)),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                         Visibility(
//                                           maintainSize: true,
//                                           maintainAnimation: true,
//                                           maintainState: true,
//                                           visible: _visible,
//                                           child: _visible && selected == index
//                                               //&&
//                                               // chatRooms
//                                               //     .chatroomUsers.isNotEmpty
//
//                                               /// selected ==index hangi butondaysa o nu çalışrma işini yapar
//                                               /// _visible(false) ise butona tıklanmadan boş container döner. butonun içinde set state ile _visible =!_visible olduğu için butona tıklandığında true olur ve asıl alanı gösterir.
//                                               ? Container(
//                                                   color: Colors.transparent,
//                                                   width: double.infinity,
//                                                   height: 200,
//                                                   child: ListView.builder(
//                                                       itemCount:
//                                                           UserProvider.length,
//                                                       itemBuilder:
//                                                           (BuildContext context,
//                                                               int index) {
//                                                         return ListTile(
//                                                           leading: Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                                     color: Colors
//                                                                         .green,
//                                                                     shape: BoxShape
//                                                                         .circle),
//                                                             width: 10,
//                                                             height: 10,
//                                                           ),
//                                                           title: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .fromLTRB(
//                                                                     0,
//                                                                     0,
//                                                                     15,
//                                                                     15),
//                                                             child: Text(
//                                                                 '${UserProvider[index].users}'),
//                                                           ),
//                                                         );
//                                                       }),
//                                                 )
//                                               : Container(),
//                                         ),
//                                       ],
//                                     );
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
