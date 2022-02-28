// import 'package:bubble/bubble.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../models/chat.dart';
//
// class DmChatWidget extends StatelessWidget {
//   const DmChatWidget({
//     Key? key,
//     required this.isMe,
//     required this.chat,
//   }) : super(key: key);
//   final bool isMe;
//   final ChatInfo chat;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () async {
//             Navigator.pop(context);
//
//             // Navigator.push(context,
//             //     MaterialPageRoute(builder: (context) => MyHomePage()));
//           },
//         ),
//         centerTitle: true,
//         // title: Text('${widget.user.users}'),
//       ),
//       body: Bubble(
//         margin: const BubbleEdges.only(top: 10),
//         alignment: isMe ? Alignment.topRight : Alignment.topLeft,
//         nipWidth: 6,
//         nipHeight: 5,
//         nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
//         color: isMe ? Colors.green : Colors.amberAccent,
//         child: Text(
//           '${chat.message}',
//         ),
//       ),
//     );
//   }
// }
