import 'package:ayna_assignment/src/app/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/local_storage/user/user_hive.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../../../../app/theme/theme.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {},
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
              sl<UserHive>().deleteLocalUser();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            },
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text('Chat', style: AppTheme.theme.textTheme.labelLarge),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: Text(
                    'User 1',
                    style: AppTheme.theme.textTheme.labelLarge,
                  ),
                  leading: CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const AssetImage('assets/images/user.png'),
                  ),
                  onTap: () => context.go('/home/message/1'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
