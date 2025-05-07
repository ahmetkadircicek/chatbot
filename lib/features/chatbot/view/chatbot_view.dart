import 'package:chatbot/features/chatbot/widget/background_widget.dart';
import 'package:chatbot/features/chatbot/widget/chatbot_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/chatbot_viewmodel.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatbotViewModel>(
      create: (context) => ChatbotViewModel(),
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundWidget(),
            ChatbotWidget(),
          ],
        ),
      ),
    );
  }
}
