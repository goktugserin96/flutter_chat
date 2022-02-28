import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../screens/screens_page_view.dart';
import 'chat_view_model.dart';

class ChatPage extends StatefulWidget {
  final ChatRooms chatRooms;

  const ChatPage({
    Key? key,
    required this.chatRooms,

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

//
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('${widget.chatRooms.name}'),
        ),
        body: Stack(
          children: [
            BackgroundContainer,
            StreamBuilder<List<ChatInfo>>(
                stream: ChatViewModel.getChatList(widget.chatRooms.id),
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

                    return Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  // shrinkWrap: true,
                                  // physics: BouncingScrollPhysics(),
                                  itemCount: chatList!.length,
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
                            child: buildTextField(appProvider),
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
        leading: Text('${chat.senderUser}:'),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: Text('${chat.message}'),
        ),
      ),
    );
  }

  Widget buildTextField(
    AppProvider chatViewModelProvider,
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

                        final newChat = ChatInfo(
                            chatroomId: widget.chatRooms.id,
                            senderUser: data!.docs.first.data()['users'] ?? "",
                            receiverUser:
                                data!.docs.first.data()['users'] ?? "",
                            message: _controller.text,
                            time: DateTime.now(),
                            userId: data!.docs.first.id);
                        chatViewModelProvider.createChat(newChat);

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
