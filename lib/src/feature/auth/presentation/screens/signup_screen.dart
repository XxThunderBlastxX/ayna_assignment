import 'package:ayna_assignment/src/app/common/widget/styled_form_field.dart';
import 'package:ayna_assignment/src/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child: Column(
            children: [
              24.verticalSpace,
              StyledFormField(
                label: 'Username',
                icon: Icon(Icons.person),
              ),
              12.verticalSpace,
              StyledFormField(
                label: 'Email',
                icon: Icon(Icons.email),
              ),
              12.verticalSpace,
              StyledFormField(
                label: 'Password',
                icon: Icon(Icons.lock),
              ),
              12.verticalSpace,
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Signup',
                    style: AppTheme.theme.textTheme.labelSmall,
                  ),
                ),
              ),
              28.verticalSpace,
              TextButton(
                onPressed: () => context.pushReplacement('/login'),
                child: Text(
                  'Already have an account? Login',
                  style: AppTheme.theme.textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
