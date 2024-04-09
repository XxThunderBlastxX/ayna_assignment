import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/cache/cache.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
          ChatSessionList(
            chatSessionId: getCachedStringList('chatSessions') ?? [],
          ),
        ) {
    on<ChatSessionCreateEvent>((event, emit) async {
      if (state is ChatSessionList) {
        final chatSessionList = getCachedStringList('chatSessions') ?? [];

        if (chatSessionList.isEmpty) {
          await cacheStringList('chatSessions', [event.sessionId]);
          chatSessionList.add(event.sessionId);
          emit(ChatSessionList(chatSessionId: chatSessionList));
          return;
        }

        chatSessionList.add(event.sessionId);
        await cacheStringList('chatSessions', chatSessionList);
        emit(ChatSessionList(chatSessionId: chatSessionList));
      }
    });
  }
}
