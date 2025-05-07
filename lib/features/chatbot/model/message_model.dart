import 'package:flutter/material.dart';

enum MessageType {
  bot,
  user,
}

class ChatMessage {
  final String text;
  final MessageType type;
  final DateTime timestamp;
  bool isRead;
  bool isSent;
  final String id;

  ChatMessage({
    required this.text,
    required this.type,
    String? id,
    DateTime? timestamp,
    this.isRead = false,
    this.isSent = true,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp = timestamp ?? DateTime.now();

  bool get isFromBot => type == MessageType.bot;

  bool get isFromUser => type == MessageType.user;

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type.toString(),
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isRead': isRead,
      'isSent': isSent,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      type: json['type'] == 'MessageType.bot'
          ? MessageType.bot
          : MessageType.user,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      isRead: json['isRead'] ?? false,
      isSent: json['isSent'] ?? true,
    );
  }

  Color getMessageColor(BuildContext context) {
    if (isFromBot) {
      return Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2B2B2B)
          : const Color(0xFFEEEEEE);
    } else {
      return Colors.grey[800]!;
    }
  }

  Color getTextColor(BuildContext context) {
    if (isFromBot) {
      return Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black87;
    } else {
      return Colors.white;
    }
  }

  Alignment getAlignment() {
    return isFromBot ? Alignment.centerLeft : Alignment.centerRight;
  }

  BorderRadius getBorderRadius() {
    if (isFromBot) {
      return const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(2),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }
  }
}
