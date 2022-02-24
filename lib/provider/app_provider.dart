import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/chat.dart';

import '../models/users.dart';
import '../views/chat/chat_view_model.dart';
import '../views/users/users_view_model.dart';

class AppProvider extends ChangeNotifier {
  List<Users> _usersList = [];

  List<Users> get usersList => _usersList;

  List<ChatInfo> _chatList = [];

  List<ChatInfo> get chatList => _chatList;

  void createUser(Users user) => UserViewModel.addNewUser(users: user);

  void setUsers(List<Users> users) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _usersList = users;
      notifyListeners();
    });
  }

  void updateUsersIsOnline(Users users, bool isOnline, String userId) {
    users.isOnline = isOnline;

    UserViewModel.updateUserOnline(users: users, userId: userId);
  }

  void createChat(ChatInfo chat) => ChatViewModel.addNewChat(chat: chat);
  void setChat(List<ChatInfo> chats) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _chatList = chats;
      notifyListeners();
    });
  }
}
