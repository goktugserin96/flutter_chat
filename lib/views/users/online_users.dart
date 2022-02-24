import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_app/provider/app_provider.dart';
import 'package:flutter_android_app/views/nickname/nickname_view.dart';
import 'package:provider/provider.dart';

class OnlineUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          BackgroundContainer,
          ListView(
              children: userProvider.usersList
                  .map(
                    (users) => ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        width: 10,
                        height: 10,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                        child: Text('${users.users} is online'),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
