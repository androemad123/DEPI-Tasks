import 'package:depi_task/core/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../../core/app widgets/message_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatScreen extends StatefulWidget {
final UserModel userModel;
const ChatScreen({super.key, required this.userModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() => messages.insert(0, text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.userModel.profileImageUrl ?? ""),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 12),
            Text(widget.userModel.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index],
                  isMe: index % 2 == 0,
                );
              },
            ),
          ),
          ChatInputField(onSend: _sendMessage),
        ],
      ),
    );
  }
}
