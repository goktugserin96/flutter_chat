import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';

class ChatMessages extends StatelessWidget {
  final bool isMe;
  final ChatInfo chat;

  const ChatMessages({
    Key? key,
    required this.isMe,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TranslatorApi.translate(chat.message);

    // print('translatedMessage $translatedMessage');

    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      nipWidth: 10,
      nipHeight: 10,
      nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isMe ? Colors.green : Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chat.receiverUser == chat.senderUser
              ? isMe
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text('You'),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                          "${chat.senderUser[0].toUpperCase() + chat.senderUser.substring(1)}"),
                    )
              : Text(""),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: chat.message.isEmpty
                ? SizedBox()
                : Text(
                    '${chat.message[0].toUpperCase() + chat.message.substring(1)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
          chat.receiverUser == chat.senderUser
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: chat.translatedMessage!.isEmpty
                      ? SizedBox()
                      : Text(
                          '${chat.translatedMessage![0].toUpperCase() + chat.translatedMessage!.substring(1)}',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.6)),
                        ),
                )
              : SizedBox(),
          Text(
            '${chat.time.hour}:${chat.time.minute}',
          ),
        ],
      ),
    );
  }
}
