import 'package:flutter/material.dart';
import 'app_bar_button.dart';

class HelpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HelpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarButton(
      icon: Icons.help_outline,
      tooltip: 'Help & Support',
      onPressed: onPressed,
    );
  }
}
