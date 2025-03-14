import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../components/featured_banner.dart';
import '../components/announcement_card.dart';
import '../components/section_header.dart';
import '../components/quick_link_button.dart';
import '../components/resource_card.dart';
import '../components/event_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        // Welcome section
        const Text(
          'Welcome to New College',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your one-stop portal for all college services',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        const SizedBox(height: 24),

        // Scroll indicator
        Center(
          child: Container(
            width: 50,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Featured Section
        FeaturedBanner(
          title: 'New College Orientation Week',
          description:
              'Join us for a week of activities to welcome new students',
          imageUrl: 'assets/images/new_college.png',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Announcements section
        const SectionHeader(title: 'Announcements', icon: Icons.campaign),
        const SizedBox(height: 8),
        AnnouncementCard(
          title: 'Fall Registration Open',
          date: 'July 15, 2023',
          description:
              'Registration for Fall 2023 courses is now open. Please check your enrollment time on ACORN.',
          priority: 'High',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        AnnouncementCard(
          title: 'Residence Move-In Weekend',
          date: 'August 30, 2023',
          description:
              'Residence move-in will begin on August 30. Check your email for specific time slots.',
          priority: 'Medium',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        AnnouncementCard(
          title: 'Winter Registration Deadline Extended',
          date: 'November 15, 2023',
          description:
              'The deadline for Winter 2024 course registration has been extended to December 1, 2023.',
          priority: 'Low',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Quick Links section
        const SectionHeader(title: 'Quick Links', icon: Icons.link),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            QuickLinkButton(
              icon: Icons.calendar_today,
              label: 'Academic Calendar',
              onTap: () {},
            ),
            QuickLinkButton(icon: Icons.book, label: 'Library', onTap: () {}),
            QuickLinkButton(icon: Icons.map, label: 'Campus Map', onTap: () {}),
            QuickLinkButton(
              icon: Icons.email,
              label: 'Contact Staff',
              onTap: () {},
            ),
            QuickLinkButton(
              icon: Icons.computer,
              label: 'Quercus',
              onTap: () {},
            ),
            QuickLinkButton(
              icon: Icons.account_balance_wallet,
              label: 'ACORN',
              onTap: () {},
            ),
            QuickLinkButton(
              icon: Icons.health_and_safety,
              label: 'Health Services',
              onTap: () {},
            ),
            QuickLinkButton(
              icon: Icons.sports,
              label: 'Athletics',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        // College Resources
        const SectionHeader(title: 'College Resources', icon: Icons.school),
        const SizedBox(height: 12),
        ResourceCard(
          title: 'New College Writing Centre',
          description:
              'Book appointments for writing support and essay feedback',
          icon: Icons.edit_document,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        ResourceCard(
          title: 'D.G. Ivey Library',
          description: 'Access study spaces, books, and resources',
          icon: Icons.local_library,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        ResourceCard(
          title: 'Academic Advising',
          description: 'Schedule meetings with college academic advisors',
          icon: Icons.people,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Upcoming Events
        const SectionHeader(title: 'Upcoming Events', icon: Icons.event_note),
        const SizedBox(height: 12),
        EventCard(
          title: 'Welcome Week Orientation',
          date: 'September 5, 2023',
          location: 'New College Quad',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        EventCard(
          title: 'Student Club Fair',
          date: 'September 10, 2023',
          location: 'Wilson Hall',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        EventCard(
          title: 'New College Student Council Meeting',
          date: 'September 15, 2023',
          location: 'Wilson Hall Room 1017',
          onTap: () {},
        ),
        // Add extra space at the bottom for better scrolling
        const SizedBox(height: 40),
      ],
    );
  }
}
