import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../../provider/app_provider.dart';
import '../../utils/translations.dart';
import '../../widgets/chat_messages_widget.dart';
import '../../widgets/title_widget.dart';
import '../nickname/nickname_view.dart';
import '../screens/screens_page_view.dart';
import 'chat_view_model.dart';

class ChatPage extends StatefulWidget {
  final ChatRooms chatRooms;
  final String meId;
  final String meName;

  const ChatPage({
    Key? key,
    required this.chatRooms,
    required this.meId,
    required this.meName,

    // required this.online
  }) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int charLength = 0;

  bool status = false;

  String language1 = Translations.languages.first;
  String language2 = Translations.languages.first;

  String fromLanguage = "";

  String toLanguage = "";

  bool isMe = false;
  TextEditingController _controller = TextEditingController();

  var translatedMessage;
  var translator = GoogleTranslator();

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

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

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
              chatroomId: widget.chatRooms.id,
              senderUser: data!.docs.first.data()['users'] ?? "",
              receiverUser: data!.docs.first.data()['users'] ?? "",
              message: message,
              translatedMessage: translatedMessage ?? "",
              time: DateTime.now(),
              userId: data!.docs.first.id));
        });
      });
    });

    status = false;
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text('${widget.chatRooms.name} Page'),
        ),
        body: Stack(
          children: [
            BackgroundContainer,
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<List<ChatInfo>>(
                      stream: ChatViewModel.getChatList(widget.chatRooms.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print('dfdfd${snapshot.data}');
                          return Center(child: Text('${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return Container();
                        } else {
                          List<ChatInfo>? chatList = snapshot.data;

                          return Expanded(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: chatList!.length,
                                  itemBuilder: (context, index) {
                                    ChatInfo chat = chatList[index];

                                    isMe = chat.userId == widget.meId &&
                                        chat.chatroomId == widget.chatRooms.id;

                                    return ChatMessages(
                                      chat: chat,
                                      isMe: isMe,
                                    );
                                  }),
                            ),
                          );
                        }
                      }),
                  buildTextField()
                ]),
          ],
        ));
  }

  Widget buildTextField() {
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
                        setState(() {
                          fromLanguage = isMe ? language1 : language2;
                          toLanguage = isMe ? language2 : language1;
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
