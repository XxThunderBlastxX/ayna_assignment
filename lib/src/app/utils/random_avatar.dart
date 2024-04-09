import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart' as avatar;

class RandomAvatar {
  static Widget getRandomAvatar(String str) {
    return avatar.RandomAvatar(
      str,
      width: 100,
      height: 100,
    );
  }
}
