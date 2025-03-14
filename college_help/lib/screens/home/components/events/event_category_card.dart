import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class EventCategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int eventCount;
  final VoidCallback onTap;

  const EventCategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.eventCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(height: 16),
              // Category title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Category description
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              // Events count
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$eventCount Events',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward, size: 16, color: color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<EventCategoryCard> getSampleCategories({
    required Function(String) onCategoryTap,
  }) {
    return [
      EventCategoryCard(
        title: 'Academic',
        description: 'Lectures, workshops, and academic events',
        icon: Icons.school,
        color: AppColors.primaryBlue,
        eventCount: 12,
        onTap: () => onCategoryTap('Academic'),
      ),
      EventCategoryCard(
        title: 'Social',
        description: 'Mixers, parties, and social gatherings',
        icon: Icons.people,
        color: AppColors.secondaryRed,
        eventCount: 8,
        onTap: () => onCategoryTap('Social'),
      ),
      EventCategoryCard(
        title: 'Sports',
        description: 'Games, tournaments, and recreational activities',
        icon: Icons.sports_basketball,
        color: Colors.orange,
        eventCount: 5,
        onTap: () => onCategoryTap('Sports'),
      ),
      EventCategoryCard(
        title: 'Arts & Culture',
        description: 'Performances, exhibitions, and cultural events',
        icon: Icons.palette,
        color: Colors.purple,
        eventCount: 9,
        onTap: () => onCategoryTap('Arts & Culture'),
      ),
      EventCategoryCard(
        title: 'Career',
        description: 'Job fairs, networking, and career development',
        icon: Icons.work,
        color: Colors.green,
        eventCount: 6,
        onTap: () => onCategoryTap('Career'),
      ),
      EventCategoryCard(
        title: 'Health & Wellness',
        description:
            'Fitness classes, health workshops, and wellness activities',
        icon: Icons.health_and_safety,
        color: Colors.teal,
        eventCount: 4,
        onTap: () => onCategoryTap('Health & Wellness'),
      ),
    ];
  }
}
