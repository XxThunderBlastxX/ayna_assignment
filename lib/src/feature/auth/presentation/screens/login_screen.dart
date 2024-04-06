import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widget/styled_form_field.dart';
import '../../../../app/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const StyledFormField(
                  label: 'Email',
                  icon: Icon(Icons.email),
                ),
                18.verticalSpace,
                const StyledFormField(
                  label: 'Password',
                  icon: Icon(Icons.lock),
                ),
                28.verticalSpace,
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: AppTheme.theme.textTheme.labelSmall,
                    ),
                  ),
                ),
                28.verticalSpace,
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: AppTheme.theme.textTheme.labelSmall,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/signup'),
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
  }
}
