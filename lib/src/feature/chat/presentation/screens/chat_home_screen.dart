import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          if (state is ChatSessionList) {
            _usernameController.clear();
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is ChatSessionList) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('New Chat'),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter username',
                                ),
                                controller: _usernameController,
                              ),
                              12.verticalSpace,
                              ElevatedButton(
                                onPressed: () => context.read<ChatBloc>().add(
                                      ChatSessionCreateEvent(
                                        sessionId:
                                            _usernameController.text.trim(),
                                      ),
                                    ),
                                child: Text(
                                  'Start Chat',
                                  style: AppTheme.theme.textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                    ),
                    child: Text(
                      'New Chat',
                      style: AppTheme.theme.textTheme.labelMedium,
                    ),
                  ),
                  12.horizontalSpace,
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      sl<SupabaseService>().client.auth.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login',
                        (route) => false,
                      );
                    },
                  ),
                ],
                title: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child:
                      Text('Chat', style: AppTheme.theme.textTheme.labelLarge),
                ),
                centerTitle: false,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                title: Text(
                                  state.chatSessionId[i].toString(),
                                  style: AppTheme.theme.textTheme.labelLarge,
                                ),
                                leading: CircleAvatar(
                                  radius: 24.r,
                                  // backgroundImage: const AssetImage('assets/images/user.png'),
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
