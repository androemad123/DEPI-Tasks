import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  const ChatInputField({super.key, required this.onSend});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration.collapsed(
                  hintText: "Type a message...",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}
