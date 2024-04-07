import 'package:flutter/material.dart';

class ChatMessageScreen extends StatelessWidget {
  final String id;

  const ChatMessageScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Message $id'),
      ),
      body: Center(
        child: Text('Chat Message $id'),
      ),
    );
  }
}
