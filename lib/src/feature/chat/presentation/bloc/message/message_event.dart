part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();
}

class SendMessageEvent extends MessageEvent {
  final String message;

  const SendMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ReceiveMessageEvent extends MessageEvent {
  final String message;

  const ReceiveMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class WebsocketConnectedEvent extends MessageEvent {
  final MessageWebsocket channel;

  const WebsocketConnectedEvent({
    required this.channel,
  });

  @override
  List<Object> get props => [channel];
}
