import 'package:codium_chat_formatter/chat_parser.dart';

class ChatProcessor {
  final String userName;
  final String botName;

  ChatProcessor({this.userName = "ES", this.botName = "avatar"});

  String processChat(String chatText) {
    var chatParser = ChatParser(userName: userName, botName: botName);
    final messages = chatParser.parseChat(chatText);
    final reversed = messages.reversed.toList();
    return reversed.map((message) => message.toString()).join("\n");
  }
}
