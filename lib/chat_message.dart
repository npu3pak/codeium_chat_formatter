import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String sender;
  final String message;
  final String timestamp;

  const ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [sender, message, timestamp];

  @override
  String toString() {
    final separator = "========================================\n";
    return "$separator$sender: \n\n$message\n";
  }
}
