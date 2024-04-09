import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/theme.dart';

Color getRandomColor() {
  final random = Random();

  List<Color> colors = [
    AppTheme.kBlueColor,
    AppTheme.kPurpleColor,
    AppTheme.kLightBlueColor,
    AppTheme.kBabyPinkColor,
  ];

  return colors[random.nextInt(colors.length)];
}
