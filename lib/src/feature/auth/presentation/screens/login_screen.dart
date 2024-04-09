import 'package:ayna_assignment/src/app/error/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widget/styled_form_field.dart';
import '../../../../app/service/service_locator.dart';
import '../../../../app/service/supabase_service.dart';
import '../../../../app/theme/theme.dart';
import '../../data/repository/auth_repository.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepo: AuthRepository(client: sl<SupabaseService>().client),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go("/home");
          } else if (state is AuthFailure) {
            context.errorBanner(
              state.failure.message,
              statusCode: state.failure.code,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      StyledFormField(
                        label: 'Email',
                        icon: const Icon(Icons.email),
                        controller: _emailController,
                      ),
                      18.verticalSpace,
                      StyledFormField(
                        label: 'Password',
                        icon: const Icon(Icons.lock),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      28.verticalSpace,
                      (state is AuthLoading)
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      SignInEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Login',
                                  style: AppTheme.theme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                      12.verticalSpace,
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        child: Text(
                          'Don\'t have an account? Sign up',
                          style: AppTheme.theme.textTheme.labelSmall,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
