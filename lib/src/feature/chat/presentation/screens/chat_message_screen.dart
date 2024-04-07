import 'package:ayna_assignment/src/feature/chat/presentation/screens/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/send_text_tile.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 0.8.sh
                      : 0.47.sh,
                  child: ListView.builder(
                    itemCount: 10,
                    // reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, i) => ChatBubble(
                      message: 'hello',
                      sendByMe: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Divider(
          //   color: AppTheme.kLightBlueColor,
          //   thickness: 1.2,
          // ),
          SendTextTile(
            controller: TextEditingController(),
            focusNode: FocusNode(),
          )
        ],
      ),
    );
  }
}
