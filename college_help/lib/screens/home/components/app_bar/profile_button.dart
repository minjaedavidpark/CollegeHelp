import 'package:flutter/material.dart';
import 'app_bar_button.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarButton(
      icon: Icons.person_outline,
      tooltip: 'Profile',
      onPressed: onPressed,
    );
  }
}
