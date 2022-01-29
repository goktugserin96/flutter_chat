import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';
import 'package:provider/provider.dart';

class OnlineUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundContainer(),
          StreamBuilder<List<Users>>(
            stream: Provider.of<UserViewModel>(context).getUsersList(),
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
                List<Users> userList = snapshot.data!;
                print('userlistsayısı ${userList}');

                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      Users users = userList[index];

                      return buildAllOnlineUsers(users);
                    });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildAllOnlineUsers(Users users) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        width: 10,
        height: 10,
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
        child: Text('${users.users} is online'),
      ),
    );
  }
}
