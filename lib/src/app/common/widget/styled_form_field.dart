import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledFormField extends StatelessWidget {
  final String label;
  final Widget? icon;
  final TextEditingController? controller;

  const StyledFormField({
    super.key,
    required this.label,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        prefixIcon: icon,
        labelText: label,
        labelStyle: AppTheme.theme.textTheme.labelMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
