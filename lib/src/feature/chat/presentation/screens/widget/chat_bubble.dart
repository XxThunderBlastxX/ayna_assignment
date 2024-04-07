import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/theme/theme.dart';

class ChatBubble extends StatelessWidget {
  final bool sendByMe;
  final String message;
  final Widget? child;

  const ChatBubble({
    super.key,
    required this.message,
    this.sendByMe = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sendByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 20,
          top: 20,
        ),
        constraints: BoxConstraints(maxWidth: 260.w),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: sendByMe ? const Color(0xffeff7f6) : AppTheme.kBlueColor,
          borderRadius: sendByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: Column(
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
