import 'package:flutter/material.dart';
import 'app_bar_button.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarButton(
      icon: Icons.search,
      tooltip: 'Search',
      onPressed: onPressed,
    );
  }
}
