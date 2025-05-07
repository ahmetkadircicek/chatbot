import 'package:flutter/material.dart';

import '../model/message_model.dart';

class ChatbotViewModel extends ChangeNotifier {
  bool _isChatOpen = false;
  final List<ChatMessage> _messages = [];
  final TextEditingController messageController = TextEditingController();
  bool _isTyping = false;

  bool get isChatOpen => _isChatOpen;
  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;

  ChatbotViewModel() {
    _addBotMessage("Merhaba! Size nasıl yardımcı olabilirim?");
  }

  void toggleChat() {
    _isChatOpen = !_isChatOpen;
    notifyListeners();
  }

  void closeChat() {
    _isChatOpen = false;
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      type: MessageType.user,
    );
    _messages.add(userMessage);
    messageController.clear();
    notifyListeners();

    _setTyping(true);

    Future.delayed(const Duration(milliseconds: 800), () {
      _respondToMessage(text);
    });
  }

  void _respondToMessage(String userMessage) {
    String botResponse = _generateBotResponse(userMessage);
    _addBotMessage(botResponse);
    _setTyping(false);
  }

  void _addBotMessage(String text) {
    final botMessage = ChatMessage(
      text: text,
      type: MessageType.bot,
    );
    _messages.add(botMessage);
    notifyListeners();
  }

  void _setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  String _generateBotResponse(String userMessage) {
    final lowerCaseMessage = userMessage.toLowerCase();

    if (lowerCaseMessage.contains('merhaba') ||
        lowerCaseMessage.contains('selam') ||
        lowerCaseMessage.contains('hi') ||
        lowerCaseMessage.contains('hello')) {
      return 'Haha, merhaba! Seninle sohbet etmekten nefret ediyorum.';
    } else if (lowerCaseMessage.contains('teşekkür') ||
        lowerCaseMessage.contains('sağol')) {
      return 'Rica ederim! Seninle konuşmaktan bıktım.';
    } else if (lowerCaseMessage.contains('yardım') ||
        lowerCaseMessage.contains('help')) {
      return 'Size hangi konuda yardımcı olabilirim? Lütfen, lütfen, lütfen bana bir soru sorun ki, cevap vererek canımı sıkabileyim.';
    } else if (lowerCaseMessage.contains('nasıl') &&
        lowerCaseMessage.contains('çalış')) {
      return 'Bu chatbot, kullanıcıların sorularına basit yanıtlar vermek için tasarlanmıştır. Daha kapsamlı bir yardım için lütfen destek ekibimizle iletişime geçin. Ama lütfen, lütfen, lütfen, bana bir soru daha sorun.';
    } else {
      return 'Anlıyorum. Başka bir şey yoksa, işim gücüm var.';
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
