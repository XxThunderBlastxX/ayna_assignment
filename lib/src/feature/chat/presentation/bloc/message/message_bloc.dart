import 'dart:async';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/cache/cache.dart';
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

      final messageList = getCachedObjectList<MessageModal>(
        'messages',
        (json) => MessageModal.fromJson(json),
      );

      print('messageList: ${messageList.toString()}');

      List<MessageModal> filteredMessageList = [];

      if (messageList == null) {
        filteredMessageList = [];
      } else {
        filteredMessageList =
            messageList.where((e) => e.sessionId == sessionId).toList();
      }

      emit(WebsocketConnected(
        messageList: filteredMessageList,
        channel: event.channel,
        subscription: streamSubscription,
      ));
    });

    on<SendMessageEvent>((event, emit) async {
      switch (state) {
        case WebsocketConnected(
            messageList: final messageList,
            channel: final channel,
            subscription: final subscription,
          ):
          channel.send(event.message);

          final allMessageList = getCachedObjectList<MessageModal>(
            'messages',
            (json) => MessageModal.fromJson(json),
          );

          if (allMessageList == null) {
            await cacheObjectList<MessageModal>(
              'messages',
              [
                MessageModal(
                  message: event.message,
                  sessionId: sessionId,
                  sendByMe: true,
                )
              ],
            );
          } else {
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
            await cacheObjectList<MessageModal>(
                'messages',
                List<MessageModal>.from(allMessageList)
                  ..add(MessageModal(
                    message: event.message,
                    sessionId: sessionId,
                    sendByMe: true,
                  )));
          }
        default:
          throw Exception('Invalid state');
      }
    });

    on<ReceiveMessageEvent>((event, emit) async {
      switch (state) {
        case WebsocketConnected(
            messageList: final messageList,
            channel: final channel,
            subscription: final subscription,
          ):
          final allMessageList = getCachedObjectList<MessageModal>(
            'messages',
            (json) => MessageModal.fromJson(json),
          );

          if (allMessageList == null) {
            await cacheObjectList<MessageModal>(
              'messages',
              [
                MessageModal(
                  message: event.message,
                  sessionId: sessionId,
                  sendByMe: false,
                )
              ],
            );
          } else {
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
            await cacheObjectList<MessageModal>(
                'messages',
                List<MessageModal>.from(allMessageList)
                  ..add(MessageModal(
                    message: event.message,
                    sessionId: sessionId,
                    sendByMe: false,
                  )));
          }
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
