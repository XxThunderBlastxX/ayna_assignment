import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/presentation/screens/login_screen.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
  ],
);
