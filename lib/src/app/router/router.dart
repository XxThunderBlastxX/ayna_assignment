import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/signup_screen.dart';
import '../../feature/chat/presentation/screens/chat_home_screen.dart';
import '../../feature/chat/presentation/screens/chat_message_screen.dart';
import '../service/supabase_service.dart';
import '../service_locator/service_locator.dart';

GoRouter router = GoRouter(
  initialLocation: sl<SupabaseService>().client.auth.currentSession != null
      ? "/home"
      : "/login",
  routes: [
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: "/signup",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SignupScreen(),
      ),
    ),
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ChatHomeScreen(),
      ),
      routes: [
        GoRoute(
          path: "message/:id",
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: ChatMessageScreen(
              id: state.pathParameters['id']!,
            ),
          ),
        ),
      ],
    ),
  ],
);
