part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatSessionList extends ChatState {
  final List<String> chatSessionId;
  final bool chatSessionDeleted;
  final bool chatSessionCreated;

  const ChatSessionList({
    required this.chatSessionId,
    this.chatSessionDeleted = false,
    this.chatSessionCreated = false,
  });

  @override
  List<Object> get props =>
      [chatSessionId, chatSessionDeleted, chatSessionCreated];
}
