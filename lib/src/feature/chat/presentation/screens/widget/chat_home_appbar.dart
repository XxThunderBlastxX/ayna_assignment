import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widget/styled_field.dart';
import '../../../../../app/theme/theme.dart';

AppBar chatHomeAppBar({
  required TextEditingController usernameController,
  required BuildContext context,
  required void Function() onLogout,
  required void Function() onNewChat,
}) {
  return AppBar(
    actions: [
      ElevatedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Colors.black87,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('New Chat'),
                  10.verticalSpace,
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: StyledField(
                      label: 'Enter Username',
                      controller: usernameController,
                    ),
                  ),
                  12.verticalSpace,
                  ElevatedButton(
                    onPressed: onNewChat,
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
        onPressed: onLogout,
      ),
    ],
    title: Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Text('Chat', style: AppTheme.theme.textTheme.labelLarge),
    ),
    centerTitle: false,
  );
}
