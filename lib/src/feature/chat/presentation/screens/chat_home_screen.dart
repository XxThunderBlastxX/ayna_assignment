import 'package:flutter/material.dart';

import '../../../../app/local_storage/user/user_hive.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../../../../app/theme/theme.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text('Chat', style: AppTheme.theme.textTheme.labelLarge),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Text('Chat Home Screen - ${sl<UserHive>().getLocalEmail()}'),
      ),
    );
  }
}
