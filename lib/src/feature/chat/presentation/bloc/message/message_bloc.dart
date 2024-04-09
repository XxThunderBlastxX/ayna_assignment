import 'dart:async';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/utils/message_websocket.dart';
import '../../modal/message/message_modal.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(String sessionId)
      : super(
          WebsocketConnecting(
            operation: CancelableOperation.fromFuture(
              Future.value(
                MessageWebsocket.connect(),
              ),
            ),
          ),
        ) {
    switch (state) {
      case WebsocketConnecting(operation: final operation):
        operation.value.then((channel) {
          add(WebsocketConnectedEvent(channel: channel));
        });
      default:
    }

    on<WebsocketConnectedEvent>((event, emit) {
      final streamSubscription = event.channel.stream.listen(
        (message) {
          add(ReceiveMessageEvent(message: message));
        },
      );

      emit(WebsocketConnected(
        messageList: const <MessageModal>[],
        channel: event.channel,
        subscription: streamSubscription,
      ));
    });

    on<SendMessageEvent>((event, emit) {
      switch (state) {
        case WebsocketConnected(
            messageList: final messageList,
            channel: final channel,
            subscription: final subscription,
          ):
          channel.send(event.message);

          emit(WebsocketConnected(
            messageList: [
              ...messageList,
              MessageModal(
                message: event.message,
                sessionId: sessionId,
                sendByMe: true,
              )
            ],
            channel: channel,
            subscription: subscription,
          ));
        default:
          throw Exception('Invalid state');
      }
    });

    on<ReceiveMessageEvent>((event, emit) {
      switch (state) {
        case WebsocketConnected(
            messageList: final messageList,
            channel: final channel,
            subscription: final subscription,
          ):
          emit(WebsocketConnected(
            messageList: [
              ...messageList,
              MessageModal(
                message: event.message,
                sessionId: sessionId,
                sendByMe: false,
              )
            ],
            channel: channel,
            subscription: subscription,
          ));
        // cacheObjectList<MessageModal>(
        //     'messages',
        //     List<MessageModal>.from(messageList)
        //       ..add(MessageModal(
        //         message: event.message,
        //         sessionId: sessionId,
        //         sendByMe: false,
        //       )));
        default:
          throw Exception('Invalid state');
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    return state.close();
  }
}
