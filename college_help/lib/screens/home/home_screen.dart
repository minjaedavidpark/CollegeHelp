import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({super.key, this.isGuest = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const _DiningTab(),
    const _ResidenceTab(),
    const _EventsTab(),
    const _AcademicsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New College Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {

            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Dining',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'Residence',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Academics'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Home Tab
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          // Announcements section
          const _SectionHeader(title: 'Announcements', icon: Icons.campaign),
          const SizedBox(height: 8),
          _AnnouncementCard(
            title: 'Fall Registration Open',
            date: 'July 15, 2023',
            description:
                'Registration for Fall 2023 courses is now open. Please check your enrollment time on ACORN.',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _AnnouncementCard(
            title: 'Residence Move-In Weekend',
            date: 'August 30, 2023',
            description:
                'Residence move-in will begin on August 30. Check your email for specific time slots.',
            onTap: () {},
          ),
          const SizedBox(height: 24),

          // Quick Links section
          const _SectionHeader(title: 'Quick Links', icon: Icons.link),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _QuickLinkButton(
                icon: Icons.calendar_today,
                label: 'Academic Calendar',
                onTap: () {},
              ),
              _QuickLinkButton(
                icon: Icons.book,
                label: 'Library',
                onTap: () {},
              ),
              _QuickLinkButton(
                icon: Icons.map,
                label: 'Campus Map',
                onTap: () {},
              ),
              _QuickLinkButton(
                icon: Icons.email,
                label: 'Contact Staff',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Upcoming Events
          const _SectionHeader(
            title: 'Upcoming Events',
            icon: Icons.event_note,
          ),
          const SizedBox(height: 12),
          _EventCard(
            title: 'Welcome Week Orientation',
            date: 'September 5, 2023',
            location: 'New College Quad',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _EventCard(
            title: 'Student Club Fair',
            date: 'September 10, 2023',
            location: 'Wilson Hall',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// Dining Tab Placeholder
class _DiningTab extends StatelessWidget {
  const _DiningTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dining information coming soon'));
  }
}

// Residence Tab Placeholder
class _ResidenceTab extends StatelessWidget {
  const _ResidenceTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Residence information coming soon'));
  }
}

// Events Tab Placeholder
class _EventsTab extends StatelessWidget {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Events calendar coming soon'));
  }
}

// Academics Tab Placeholder
class _AcademicsTab extends StatelessWidget {
  const _AcademicsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Academic resources coming soon'));
  }
}

// Common UI Components

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text('See All')),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final VoidCallback onTap;

  const _AnnouncementCard({
    required this.title,
    required this.date,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final VoidCallback onTap;

  const _EventCard({
    required this.title,
    required this.date,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.event, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickLinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickLinkButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}
