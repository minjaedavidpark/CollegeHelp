import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: Icon(Icons.event, size: 80, color: AppColors.primaryBlue),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Events Calendar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'College events and activities calendar coming soon',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        // Add more placeholder content to ensure scrolling works for testing
        const SizedBox(height: 1000),
      ],
    );
  }
}
