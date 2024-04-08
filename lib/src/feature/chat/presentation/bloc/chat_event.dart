part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatSessionCreateEvent extends ChatEvent {
  final String sessionId;

  const ChatSessionCreateEvent({
    required this.sessionId,
  });

  @override
  List<Object> get props => [sessionId];
}
