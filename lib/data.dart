import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';

// final String TR = "TR";
// final String RS = "RS";
// final String DE = "DE";
// final String ES = "ES";

// var  countries2 =
// { "TR": "Turkish",
//   "GB": "English",
//   "DE": "Germany",
//   "ES": "Spanish"};

// final imageUrl = "https://github.com/madebybowtie/FlagKit/blob/master/Assets/PNG/TR.png"

List<ChatRooms> chatroomsList = [
  ChatRooms(
      name: "Turkish",
      flagImage:
          "https://www.istardanismanlik.com/media/haberResimleri/1730-1195-77122.jpg"),
  ChatRooms(
      name: "Russian",
      flagImage:
          "https://media.istockphoto.com/photos/flag-of-russia-picture-id489481953?k=20&m=489481953&s=612x612&w=0&h=_fxq--gIkMUt4bnhujwK1LDd_hA8Wk1qu5XlGQntsgI="),
  ChatRooms(
      name: "Spanish",
      flagImage:
          "https://stuffedeyes.files.wordpress.com/2018/06/spain-2906824_960_720.png?w=640"),
  ChatRooms(
      name: "German",
      flagImage:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/2560px-Flag_of_Germany.svg.png")
];

List<ChatInfo> chatList = [
  ChatInfo(
      chatroomId: "",
      message: "Service Message",
      time: DateTime.now(),
      userId: ""),
];

// countries2.keys.map((e){
//
// final imageUrl = "https://github.com/madebybowtie/FlagKit/blob/master/Assets/PNG/$e.png";
//
// return print('$imageUrl');}).toList();
