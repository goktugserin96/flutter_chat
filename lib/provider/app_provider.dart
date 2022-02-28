import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/chat.dart';

import '../models/users.dart';
import '../views/chat/chat_view_model.dart';

class AppProvider extends ChangeNotifier {
  List<Users> _usersList = [];

  List<Users> get usersList => _usersList;

  List<ChatInfo> _chatList = [];

  List<ChatInfo> get chatList => _chatList;

  // void createUser(Users user) => UserViewModel.addNewUser(users: user);
  //
  // void addChat(ChatInfo chat) {
  //
  //
  //   chatList.add(chat);
  //   notifyListeners();
  //
  // }

  void setChats(List<ChatInfo> chats) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _chatList = chats;
      notifyListeners();
    });
  }

  // void deneme(ChatInfo chat) {
  //   _chatList.add(chat);
  //   notifyListeners();
  // }

  void setUsers(List<Users> users) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _usersList = users;
      notifyListeners();
    });
  }

  // void updateUsersIsOnline(Users users, String userId, List<ChatInfo> chats) {
  //   users.chats = chats;
  //
  //   UserViewModel.updateUserOnline(users: users, userId: userId);
  // }

  void createChat(ChatInfo chat) => ChatViewModel.addNewChat(chat: chat);
}
