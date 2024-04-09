import 'package:ayna_assignment/src/app/utils/colors.dart';
import 'package:ayna_assignment/src/app/utils/random_avatar.dart';
import 'package:ayna_assignment/src/feature/chat/presentation/screens/widget/chat_home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/service/supabase_service.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../../../../app/theme/theme.dart';
import '../bloc/chat/chat_bloc.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(),
        ),
      ],
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatSessionList && state.chatSessionCreated) {
            _usernameController.clear();
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is ChatSessionList) {
            return Scaffold(
              appBar: chatHomeAppBar(
                usernameController: _usernameController,
                context: context,
                onLogout: () {
                  sl<SupabaseService>().client.auth.signOut();
                  context.pushReplacement("/login");
                },
                onNewChat: () => context.read<ChatBloc>().add(
                      ChatSessionCreateEvent(
                        sessionId: _usernameController.text.trim(),
                      ),
                    ),
              ),
              body: Column(
                children: [
                  const Divider(),
                  state.chatSessionId.isEmpty
                      ? const Center(
                          child: Text(
                              "Opps, Not chat yet !!!\nChat by pressing \"New Chat\" button"),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.chatSessionId.length,
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                tileColor: getRandomColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Colors.black87,
                                    width: 2,
                                  ),
                                ),
                                title: Text(
                                  state.chatSessionId[i].toString(),
                                  style: AppTheme.theme.textTheme.labelLarge,
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () => context.read<ChatBloc>().add(
                                        ChatSessionDeletedEvent(
                                            sessionId: state.chatSessionId[i]),
                                      ),
                                  child: Text(
                                    'Delete Chat',
                                    style: AppTheme.theme.textTheme.labelMedium,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  radius: 24,
                                  child: RandomAvatar.getRandomAvatar(
                                      state.chatSessionId[i]),
                                ),
                                onTap: () => context.go(
                                    '/home/message/${state.chatSessionId[i]}'),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
