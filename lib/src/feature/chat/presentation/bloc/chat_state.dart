part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatSessionList extends ChatState {
  final List<String> chatSessionId;

  const ChatSessionList({
    required this.chatSessionId,
  });

  @override
  List<Object> get props => [chatSessionId];
}
