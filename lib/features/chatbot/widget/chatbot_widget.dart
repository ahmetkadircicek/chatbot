import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../model/message_model.dart';
import '../viewmodel/chatbot_viewmodel.dart';

class ChatbotWidget extends StatelessWidget {
  const ChatbotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildChatBox(context),
        _buildChatButton(context),
      ],
    );
  }

  Widget _buildChatButton(BuildContext context) {
    final viewModel = Provider.of<ChatbotViewModel>(context);

    return Positioned(
      bottom: AppTheme.chatButtonPosition.bottom,
      right: AppTheme.chatButtonPosition.right,
      child: GestureDetector(
        onTap: viewModel.toggleChat,
        child: AnimatedContainer(
          clipBehavior: Clip.hardEdge,
          duration: AppTheme.animationDuration,
          curve: Curves.easeInOut,
          width: viewModel.isChatOpen
              ? AppTheme.chatButtonSizeOpen
              : AppTheme.chatButtonSizeClosed,
          height: viewModel.isChatOpen
              ? AppTheme.chatButtonSizeOpen
              : AppTheme.chatButtonSizeClosed,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(64),
              topRight: Radius.circular(64),
              bottomLeft: Radius.circular(64),
              bottomRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.question_mark,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBox(BuildContext context) {
    final viewModel = Provider.of<ChatbotViewModel>(context);

    return AnimatedPositioned(
      duration: AppTheme.slideAnimationDuration,
      curve: Curves.easeOutBack,
      bottom: viewModel.isChatOpen ? AppTheme.chatBoxPosition.bottom : -450,
      right: AppTheme.chatBoxPosition.right,
      child: AnimatedOpacity(
        opacity: viewModel.isChatOpen ? 1.0 : 0.0,
        duration: AppTheme.slideAnimationDuration,
        child: Container(
          width: AppTheme.chatBoxWidth,
          height: AppTheme.chatBoxHeight,
          decoration: AppTheme.chatBoxDecoration,
          child: Column(
            children: [
              _buildChatHeader(context),
              Expanded(
                child: _buildChatMessages(context),
              ),
              if (viewModel.isTyping) _buildTypingIndicator(),
              _buildChatInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatHeader(BuildContext context) {
    return Container(
      padding: AppTheme.chatHeaderPadding,
      decoration: AppTheme.chatHeaderDecoration,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'IZUBOT',
              style: AppTheme.headerTextStyle,
            ),
          ),
          GestureDetector(
            onTap: () => Provider.of<ChatbotViewModel>(context, listen: false)
                .closeChat(),
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages(BuildContext context) {
    final viewModel = Provider.of<ChatbotViewModel>(context);

    return ListView.builder(
      padding: AppTheme.defaultPadding,
      itemCount: viewModel.messages.length,
      reverse: false,
      itemBuilder: (context, index) {
        final message = viewModel.messages[index];
        return _buildMessageItem(context, message);
      },
    );
  }

  Widget _buildMessageItem(BuildContext context, ChatMessage message) {
    return Align(
      alignment: message.getAlignment(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppTheme.chatBoxWidth * 0.75,
        ),
        margin: AppTheme.messageBottomPadding,
        padding: AppTheme.chatMessagePadding,
        decoration: BoxDecoration(
          color: message.getMessageColor(context),
          borderRadius: message.getBorderRadius(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: AppTheme.messageTextStyle.copyWith(
                color: message.getTextColor(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.formattedTime,
              style: TextStyle(
                fontSize: 10,
                color: message.isFromBot ? Colors.black54 : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          _buildDot(0),
          _buildDot(150),
          _buildDot(300),
        ],
      ),
    );
  }

  Widget _buildDot(int delay) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(value),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    final viewModel = Provider.of<ChatbotViewModel>(context);

    return Container(
      padding: AppTheme.chatInputPadding,
      decoration: AppTheme.chatInputDecoration,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: viewModel.messageController,
              decoration: AppTheme.textFieldDecoration,
              onSubmitted: (text) => viewModel.sendMessage(text),
            ),
          ),
          SizedBox(width: AppTheme.horizontalSpacing.horizontal / 2),
          Container(
            decoration: AppTheme.sendButtonDecoration,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () =>
                  viewModel.sendMessage(viewModel.messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}
