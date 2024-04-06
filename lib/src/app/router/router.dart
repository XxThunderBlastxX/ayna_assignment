import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/signup_screen.dart';

GoRouter router = GoRouter(
  initialLocation: "/login",
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
  ],
);
