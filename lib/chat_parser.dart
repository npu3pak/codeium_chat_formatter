import 'package:codeium_chat_formatter/chat_message.dart';

class ChatParser {
  final String userName;
  final String botName;

  ChatParser({required this.userName, this.botName = "avatar"});

  List<ChatMessage> parseChat(String text) {
    var chatText = text;
    chatText = removeTextBeforeSender(chatText);
    chatText = removeTextAfterClear(chatText);

    List<ChatMessage> chatMessages = [];

    List<String> lines = chatText.split('\n');
    if (lines.last.isEmpty) {
      lines.removeLast();
    }

    List<int> newMessageIndexes = [];
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].trim() == userName || lines[i].trim() == botName) {
        newMessageIndexes.add(i);
      }
    }

    for (int i = 0; i < newMessageIndexes.length; i++) {
      final senderIndex = newMessageIndexes[i];

      final sender = lines[senderIndex].trim();

      final dateIndex = i < newMessageIndexes.length - 1
          ? newMessageIndexes[i + 1] - 1
          : lines.length - 1;

      final timestamp = lines[dateIndex].trim();

      final message =
          lines.getRange(senderIndex + 1, dateIndex - 1).join("\n").trim();
      final chatMessage =
          ChatMessage(sender: sender, message: message, timestamp: timestamp);

      chatMessages.add(chatMessage);
    }

    return chatMessages;
  }

  String removeTextBeforeSender(String chatText) {
    int startIndex = chatText.indexOf(botName);
    if (startIndex == -1) {
      startIndex = chatText.indexOf(userName);
    }
    if (startIndex == -1) {
      return chatText;
    }
    return chatText.substring(startIndex);
  }

  String removeTextAfterClear(String chatText) {
    int endIndex = chatText.indexOf("Clear conversation");
    if (endIndex == -1) {
      return chatText;
    }
    return chatText.substring(0, endIndex);
  }
}
