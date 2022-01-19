enum ChatRoomType { room1, room2, room3 }

String getChatRoomType(ChatRoomType type) {
  switch (type) {
    case ChatRoomType.room1:
      return "Chat Room 1";
    case ChatRoomType.room2:
      return "Chat Room 2";
    case ChatRoomType.room3:
      return "Chat Room 3";
  }
}
