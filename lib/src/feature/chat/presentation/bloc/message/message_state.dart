part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  FutureOr<void> close();
}

final class WebsocketConnected extends MessageState {
  final List<MessageModal> messageList;
  final MessageWebsocket channel;
  final StreamSubscription<String> subscription;

  const WebsocketConnected({
    required this.messageList,
    required this.channel,
    required this.subscription,
  });

  @override
  List<Object> get props => [messageList, channel, subscription];

  @override
  void close() async {
    await subscription.cancel();
    await channel.close();
  }
}

final class WebsocketConnecting extends MessageState {
  final CancelableOperation<MessageWebsocket> operation;

  const WebsocketConnecting({
    required this.operation,
  });

  @override
  List<Object?> get props => [operation];

  @override
  void close() async {
    await operation.cancel();
  }
}
