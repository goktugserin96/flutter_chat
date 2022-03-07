import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/provider/app_provider.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../../data.dart';
import '../../utils/translations.dart';
import '../../widgets/chat_messages_widget.dart';
import '../../widgets/title_widget.dart';
import '../screens/screens_page_view.dart';
import 'chat_view_model.dart';

QuerySnapshot<Map<String, dynamic>>? chatData;

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
  void initState() {
    getData();

    super.initState();
  }

  String language1 = Translations.languages.first;
  String language2 = Translations.languages.first;

  String fromLanguage = "";

  String toLanguage = "";
  bool isMe = false;

  var translatedMessage;
  var translator = GoogleTranslator();

  void saveChatMessages() {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    var message = _controller.text;

    setState(() {
      final fromLanguageCode = Translations.getLanguageCode(fromLanguage);
      final toLanguageCode = Translations.getLanguageCode(toLanguage);
      print('fromlanguage $fromLanguage');
      print('toLanguage $toLanguage');

      translator
          .translate(_controller.text,
              from: fromLanguageCode, to: toLanguageCode)
          .then((value) {
        setState(() {
          translatedMessage = value.text;
          provider.createChat(ChatInfo(
            chatroomId: data!.docs.first.id,
            senderUser: data!.docs.first.data()['users'] ?? "",
            receiverUser: widget.userName,
            message: message,
            translatedMessage: translatedMessage ?? "",
            time: DateTime.now(),
            userId: widget.userId,
          ));
        });
      });
    });

    status = false;
    _controller.clear();
  }

  bool isLoading = false;
  void getData() async {
    await FirebaseFirestore.instance
        .collection('chat')
        .where('chatroomId', isEqualTo: widget.userId)
        .where('userId', isEqualTo: data!.docs.first.id)
        .get()
        .then((value) {
      setState(() {
        chatData = value;
        isLoading = false;
      });
    });
  }

//
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: buildTitle(),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('${widget.userName}'),
        ),
        body: Stack(
          children: [
            BackgroundContainer,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<List<ChatInfo>>(
                    stream: ChatViewModel.getPrivateChatList(
                        data!.docs.first.id,
                        widget.userId), //UserProvider[0].id
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print('dfdfd${snapshot.data}');
                        return Center(child: Text('${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Container();
                      } else {
                        List<ChatInfo>? chatList = snapshot.data;

                        Provider.of<AppProvider>(context).setChats(chatList!);

                        return Expanded(
                          child: Container(
                            child: ListView.builder(
                                itemCount: chatList.length,
                                itemBuilder: (context, i) {
                                  ChatInfo chat = chatList[i];

                                  isMe = chat.userId == widget.userId &&
                                      chat.chatroomId == data!.docs.first.id;

                                  final deneme1 =
                                      chat.chatroomId == data!.docs.first.id;

                                  final deneme2 = chat.userId == widget.userId;

                                  final deneme3 =
                                      chat.chatroomId == widget.userId;

                                  final deneme4 =
                                      chat.userId == data!.docs.first.id;
//
                                  return buildChatArea(chat, isMe, deneme1,
                                      deneme2, deneme3, deneme4);
                                }),
                          ),
                        );
                      }
                    }),
                buildTextField(appProvider, chatList),
              ],
            ),
          ],
        ));
  }

  Widget buildChatArea(
      ChatInfo chat, bool isMe, bool deneme1, bool deneme2, deneme3, deneme4) {
    return (deneme1 && deneme2) || (deneme3 && deneme4)
        ? ChatMessages(
            chat: chat,
            isMe: isMe,
          )
        : Container();
  }

//
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
                        // status = false;

                        // final newChat = ChatInfo(
                        //   chatroomId: data!.docs.first.id,
                        //   senderUser: data!.docs.first.data()['users'] ?? "",
                        //   receiverUser: widget.userName,
                        //   message: _controller.text,
                        //   time: DateTime.now(),
                        //   userId: widget.userId,
                        // );
                        // ChatViewModelProvider.createChat(newChat);

                        // ChatViewModelProvider.updateUsersIsOnline(
                        //     widget.user, widget.user.id, chatList);

                        // _controller.clear();

                        setState(() {
                          fromLanguage = language1;
                          toLanguage = language2;
                        });

                        saveChatMessages();
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

  Widget buildTitle() => TitleWidget(
        language1: language1,
        language2: language2,
        onChangedLanguage1: (newLanguage) => setState(() {
          language1 = newLanguage!;
        }),
        onChangedLanguage2: (newLanguage) => setState(() {
          language2 = newLanguage!;
        }),
      );
}
