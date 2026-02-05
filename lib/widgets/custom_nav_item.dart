import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomNavItem {
  static ItemConfig build({
    required BuildContext context,
    required String iconPath,
    required String title,
  }) {
    return ItemConfig(
      activeForegroundColor: Theme.of(context).primaryColor,
      icon: Image.asset(
        iconPath,
        height: 26,
        color: Theme.of(context).primaryColor,
      ),

      inactiveIcon: Image.asset(
        iconPath,
        height: 38,
        width: 28,
        color: Colors.blueGrey.shade200,
      ),
      title: title,
    );
  }
}
