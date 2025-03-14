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
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          IconButton(icon: const Icon(Icons.account_circle), onPressed: () {}),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Disable swiping between tabs
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          _HomeTab(),
          _DiningTab(),
          _ResidenceTab(),
          _EventsTab(),
          _AcademicsTab(),
        ],
      ),
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
          _pageController.jumpToPage(index);
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
    // Calculate available height for content
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final bottomNavHeight = kBottomNavigationBarHeight;
    final availableHeight =
        screenHeight - statusBarHeight - appBarHeight - bottomNavHeight;

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
        _FeaturedBanner(
          title: 'New College Orientation Week',
          description:
              'Join us for a week of activities to welcome new students',
          imageUrl: 'assets/images/orientation.jpg',
          onTap: () {},
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
          priority: 'High',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _AnnouncementCard(
          title: 'Residence Move-In Weekend',
          date: 'August 30, 2023',
          description:
              'Residence move-in will begin on August 30. Check your email for specific time slots.',
          priority: 'Medium',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _AnnouncementCard(
          title: 'Winter Registration Deadline Extended',
          date: 'November 15, 2023',
          description:
              'The deadline for Winter 2024 course registration has been extended to December 1, 2023.',
          priority: 'Low',
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
            _QuickLinkButton(icon: Icons.book, label: 'Library', onTap: () {}),
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
            _QuickLinkButton(
              icon: Icons.computer,
              label: 'Quercus',
              onTap: () {},
            ),
            _QuickLinkButton(
              icon: Icons.account_balance_wallet,
              label: 'ACORN',
              onTap: () {},
            ),
            _QuickLinkButton(
              icon: Icons.health_and_safety,
              label: 'Health Services',
              onTap: () {},
            ),
            _QuickLinkButton(
              icon: Icons.sports,
              label: 'Athletics',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        // College Resources
        const _SectionHeader(title: 'College Resources', icon: Icons.school),
        const SizedBox(height: 12),
        _ResourceCard(
          title: 'New College Writing Centre',
          description:
              'Book appointments for writing support and essay feedback',
          icon: Icons.edit_document,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _ResourceCard(
          title: 'D.G. Ivey Library',
          description: 'Access study spaces, books, and resources',
          icon: Icons.local_library,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _ResourceCard(
          title: 'Academic Advising',
          description: 'Schedule meetings with college academic advisors',
          icon: Icons.people,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Upcoming Events
        const _SectionHeader(title: 'Upcoming Events', icon: Icons.event_note),
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
        const SizedBox(height: 12),
        _EventCard(
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

// Dining Tab Placeholder
class _DiningTab extends StatelessWidget {
  const _DiningTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: Icon(
            Icons.restaurant_menu,
            size: 80,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Dining Information',
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
            'Menus and meal plan information coming soon',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        // Add more placeholder content to ensure scrolling works for testing
        const SizedBox(height: 1000),
      ],
    );
  }
}

// Residence Tab Placeholder
class _ResidenceTab extends StatelessWidget {
  const _ResidenceTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: Icon(Icons.apartment, size: 80, color: AppColors.primaryBlue),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Residence Information',
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
            'Housing details and residence services coming soon',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        // Add more placeholder content to ensure scrolling works for testing
        const SizedBox(height: 1000),
      ],
    );
  }
}

// Events Tab Placeholder
class _EventsTab extends StatelessWidget {
  const _EventsTab();

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

// Academics Tab Placeholder
class _AcademicsTab extends StatelessWidget {
  const _AcademicsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: Icon(Icons.school, size: 80, color: AppColors.primaryBlue),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Academic Resources',
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
            'Course information and academic support coming soon',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        // Add more placeholder content to ensure scrolling works for testing
        const SizedBox(height: 1000),
      ],
    );
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
  final String priority;
  final VoidCallback onTap;

  const _AnnouncementCard({
    required this.title,
    required this.date,
    required this.description,
    this.priority = 'Medium',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    switch (priority) {
      case 'High':
        priorityColor = Colors.red.shade700;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: priorityColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 12, color: priorityColor),
                    ),
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Priority: ',
                    style: TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      priority,
                      style: TextStyle(
                        fontSize: 12,
                        color: priorityColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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

// Featured Banner
class _FeaturedBanner extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const _FeaturedBanner({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 150,
                width: double.infinity,
                color: AppColors.primaryBlue.withOpacity(0.2),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback when image can't be loaded
                    return Center(
                      child: Icon(
                        Icons.image,
                        size: 64,
                        color: AppColors.primaryBlue.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Learn More'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// College Resource Card
class _ResourceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ResourceCard({
    required this.title,
    required this.description,
    required this.icon,
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
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryBlue, size: 30),
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
                      description,
                      style: TextStyle(fontSize: 14, color: AppColors.textDark),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
