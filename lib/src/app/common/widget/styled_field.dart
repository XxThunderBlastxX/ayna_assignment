import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledField extends StatelessWidget {
  final String label;
  final Widget? icon;
  final TextEditingController? controller;

  const StyledField({
    super.key,
    required this.label,
    this.icon,
    this.controller,
  });

  InputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black87,
        width: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        prefixIcon: icon,
        labelText: label,
        labelStyle: AppTheme.theme.textTheme.labelMedium,
        enabledBorder: getBorder(),
        focusedBorder: getBorder(),
      ),
    );
  }
}
