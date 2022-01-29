import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/views/screens/screens_page_view.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class NickNamePage extends StatefulWidget {
  const NickNamePage({Key? key}) : super(key: key);

  @override
  _NickNamePageState createState() => _NickNamePageState();
}

class _NickNamePageState extends State<NickNamePage> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 32, 47),
      body: Stack(
        children: [
          BackgroundContainer(),
          NickName(nameController: _nameController),
        ],
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: assetImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NickName extends StatefulWidget {
  const NickName({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  State<NickName> createState() => _NickNameState();
}

class _NickNameState extends State<NickName> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            child: TextField(
              controller: widget._nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter your name'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//                 ChatRoomType.values.map((type) {
//                   final name = getChatRoomType(type);
//
//                   Provider.of<ChatroomViewModel>(context, listen: false)
//                       .addNewChatroomUsers(chatRoomsName: name);
//                 }).toList();

                Provider.of<UserViewModel>(context, listen: false) // list
                    .addNewUser(
                  users: widget._nameController.text,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },
              child: Text("Enter Chat Room"))
        ],
      ),
    );
  }
}
