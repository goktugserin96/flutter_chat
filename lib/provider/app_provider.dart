import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/views/users/users_view_model.dart';

import '../models/users.dart';
import '../views/chat/chat_view_model.dart';

class AppProvider extends ChangeNotifier {
  List<Users> _usersList = [];

  List<Users> get usersList => _usersList;

  // List<Users> get chatroomsUsers =>
  //     _usersList.where((element) => element.isOnline == true).toList();

  List<ChatInfo> _chatList = [];

  List<ChatInfo> get chatList => _chatList;

  List<ChatRooms> _chatRoomList = [];

  List<ChatRooms> get chatRoomList => _chatRoomList;
  // void createUser(Users user) => UserViewModel.addNewUser(users: user);
  //
  // void addChat(ChatInfo chat) {
  //
  //
  //   chatList.add(chat);
  //   notifyListeners();
  //
  // }

  void updateUsers(Users users, String chatroomId, String userId) {
    users.chatRoomId = chatroomId;

    UserViewModel.updateUserOnline(
        users: users, chatroomId: chatroomId, userId: userId);
  }

  void setChats(List<ChatInfo> chats) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _chatList = chats;
      notifyListeners();
    });
  }

  void setChatRooms(List<ChatRooms> chatrooms) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _chatRoomList = chatrooms;
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
