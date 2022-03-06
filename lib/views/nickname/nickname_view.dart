// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_android_app/views/screens/screens_page_view.dart';
// import 'package:flutter_android_app/views/users/users_view_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../main.dart';
//
// class NickNamePage extends StatefulWidget {
//   const NickNamePage({Key? key}) : super(key: key);
//
//   @override
//   _NickNamePageState createState() => _NickNamePageState();
// }
//
// class _NickNamePageState extends State<NickNamePage> {
//   TextEditingController _nameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("NickName Page"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () => FirebaseAuth.instance.signOut(),
//               icon: Icon(Icons.logout))
//         ],
//       ),
//       backgroundColor: Color.fromARGB(255, 18, 32, 47),
//       body: Stack(
//         children: [
//           BackgroundContainer,
//           buildNickName(user, context),
//         ],
//       ),
//     );
//   }
//
//   Center buildNickName(User user, BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('${user.email}'),
//           Container(
//             width: 300,
//             child: TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(), hintText: 'Enter your name'),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _nameController.text = user.email!;
//                 });
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //
// //                 ChatRoomType.values.map((type) {
// //                   final name = getChatRoomType(type);
// //
// //                   Provider.of<ChatroomViewModel>(context, listen: false)
// //                       .addNewChatroomUsers(chatRoomsName: name);
// //                 }).toList();
//
//                 Provider.of<UserViewModel>(context, listen: false) // list
//                     .addNewUser(
//                   users: _nameController.text,
//                   email: FirebaseAuth.instance.currentUser!.email,
//                 );
//
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ScreensPage(),
//                     ));
//               },
//               child: Text("Enter Chat Room"))
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/cupertino.dart';

const AssetImage assetImage = AssetImage("assets/images/background.png");

Widget BackgroundContainer = Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: assetImage,
      fit: BoxFit.cover,
    ),
  ),
);
