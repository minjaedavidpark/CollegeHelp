import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'tabs/home_tab.dart';
import 'tabs/dining_tab.dart';
import 'tabs/residence_tab.dart';
import 'tabs/events_tab.dart';
import 'tabs/registrar_tab.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({super.key, this.isGuest = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  final List<String> _tabTitles = [
    'Home',
    'Dining',
    'Residence',
    'Events',
    'Registrar\'s Office',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildEnhancedAppBar(),
      body: Container(
        // Add a subtle gradient to the entire app background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: const [
              HomeTab(),
              DiningTab(),
              ResidenceTab(),
              EventsTab(),
              RegistrarTab(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildAnimatedNavBar(),
    );
  }

  // Enhanced app bar with animation and modern design
  PreferredSizeWidget _buildEnhancedAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          flexibleSpace: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00205C), // Deeper blue
                      AppColors.primaryBlue,
                      const Color(0xFF0A3A7D), // Slightly lighter blue
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: TopBarWavePainter(
                    animation: _animationController.value,
                  ),
                  child: child,
                ),
              );
            },
            child: const SizedBox.expand(),
          ),
          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decorative dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.secondaryRed.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              // Main title text
              const Text(
                'New College Portal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 10),
              // Second decorative dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.secondaryRed.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            _buildNotificationButton(),
            const SizedBox(width: 6),
            _buildProfileButton(),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.notifications_outlined,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          // Show notifications
        },
        tooltip: 'Notifications',
      ),
    );
  }

  Widget _buildProfileButton() {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          // Show profile
        },
        tooltip: 'Profile',
      ),
    );
  }

  Widget _buildAnimatedNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
        ),
        elevation: 0,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Registrar\'s',
          ),
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

// Wave painter for app bar animation
class TopBarWavePainter extends CustomPainter {
  final double animation;

  TopBarWavePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle wave patterns
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.07)
          ..style = PaintingStyle.fill;

    const wavePeriod = 3.0;
    const waveAmplitude = 4.0;

    final path = Path();

    // Starting from the bottom
    path.moveTo(0, size.height * 0.8);

    // Drawing the wave
    for (double x = 0; x <= size.width; x++) {
      final y =
          size.height * 0.8 +
          math.sin(
                (x / size.width * wavePeriod * math.pi) +
                    (animation * math.pi * 2),
              ) *
              waveAmplitude;
      path.lineTo(x, y);
    }

    // Completing the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw some decorative particles
    final particlePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final particleX = size.width * ((i * 127) % 100) / 100;
      final particleY = size.height * ((i * 59) % 60) / 100;
      final particleSize = 0.5 + ((i * 13) % 3) / 2;

      canvas.drawCircle(
        Offset(particleX, particleY),
        particleSize,
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TopBarWavePainter oldDelegate) {
    return oldDelegate.animation != animation;
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
          imageUrl: 'assets/images/new_college.png',
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

// Dining Tab
class _DiningTab extends StatelessWidget {
  const _DiningTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header section
        const Text(
          'Dining at New College',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore dining options, meal plans, and special dietary services',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        const SizedBox(height: 24),

        // Featured Dining Hall
        _FeaturedDiningCard(
          name: 'Wilson Hall Dining Commons',
          description:
              'The main dining hall at New College, offering a diverse range of culinary options for students and faculty.',
          imageUrl: 'assets/images/dining_hall.jpg',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Today's Menu section
        const _SectionHeader(
          title: "Today's Menu Highlights",
          icon: Icons.restaurant,
        ),
        const SizedBox(height: 12),

        _MenuHighlightCard(
          mealType: 'Breakfast',
          timeRange: '7:30 AM - 10:30 AM',
          highlights: [
            'Belgian Waffles with Fresh Berries',
            'Vegetable Frittata (Vegetarian)',
            'Assorted Breakfast Pastries',
            'Fresh Fruit Bar',
          ],
          icon: Icons.free_breakfast,
          onTap: () {},
        ),
        const SizedBox(height: 12),

        _MenuHighlightCard(
          mealType: 'Lunch',
          timeRange: '11:30 AM - 2:30 PM',
          highlights: [
            'Herb Roasted Chicken with Potatoes',
            'Mushroom Risotto (Vegetarian)',
            'Build-Your-Own Sandwich Station',
            'Seasonal Soup Bar',
          ],
          icon: Icons.lunch_dining,
          onTap: () {},
        ),
        const SizedBox(height: 12),

        _MenuHighlightCard(
          mealType: 'Dinner',
          timeRange: '5:00 PM - 8:00 PM',
          highlights: [
            'Salmon with Lemon Dill Sauce',
            'Eggplant Parmesan (Vegetarian)',
            'Stir-Fry Station (Vegan Options)',
            'Daily Special: Taco Tuesday',
          ],
          icon: Icons.dinner_dining,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Meal Plan Options
        const _SectionHeader(title: 'Meal Plan Options', icon: Icons.payment),
        const SizedBox(height: 12),
        _MealPlanCard(
          title: 'Standard Meal Plan',
          description: '15 meals per week + \$100 flex dollars per semester',
          price: '\$2,400 per semester',
          features: [
            'Rollover meals within the week',
            'Guest passes (2 per month)',
            'Access to all campus dining locations',
          ],
          recommended: true,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _MealPlanCard(
          title: 'Premium Meal Plan',
          description: 'Unlimited meals + \$200 flex dollars per semester',
          price: '\$2,800 per semester',
          features: [
            'Unlimited dining hall access',
            'Guest passes (5 per month)',
            'Special event access',
            'Late night dining option',
          ],
          recommended: false,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _MealPlanCard(
          title: 'Basic Meal Plan',
          description: '10 meals per week + \$50 flex dollars per semester',
          price: '\$1,800 per semester',
          features: [
            'No rollover meals',
            'Guest passes (1 per month)',
            'Access to main dining hall only',
          ],
          recommended: false,
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Dining Locations
        const _SectionHeader(
          title: 'Campus Dining Locations',
          icon: Icons.place,
        ),
        const SizedBox(height: 12),
        _LocationCard(
          name: 'Wilson Hall Dining Commons',
          hours: 'Mon-Fri: 7:30 AM - 8:00 PM\nSat-Sun: 9:00 AM - 7:00 PM',
          description:
              'Main dining hall with multiple stations and rotating menu options.',
          icons: [Icons.accessible, Icons.eco, Icons.health_and_safety],
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _LocationCard(
          name: 'Wetmore Hall Café',
          hours: 'Mon-Fri: 8:00 AM - 2:00 PM\nClosed weekends',
          description:
              'Coffee, pastries, and grab-and-go sandwiches and salads.',
          icons: [Icons.eco, Icons.coffee],
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _LocationCard(
          name: '45 Willcocks Street Bistro',
          hours:
              'Mon-Thu: 11:00 AM - 7:00 PM\nFri: 11:00 AM - 3:00 PM\nClosed weekends',
          description:
              'À la carte dining with specialty items and international cuisine.',
          icons: [Icons.accessible, Icons.eco, Icons.local_bar],
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Dietary Accommodations
        const _SectionHeader(
          title: 'Dietary Accommodations',
          icon: Icons.health_and_safety,
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _DietaryOptionTile(
              title: 'Vegetarian Options',
              description: 'Available at all stations in every dining location',
              icon: Icons.eco,
            ),
            _DietaryOptionTile(
              title: 'Vegan Options',
              description:
                  'Dedicated vegan station at Wilson Hall and labeled options at all locations',
              icon: Icons.spa,
            ),
            _DietaryOptionTile(
              title: 'Gluten-Free Options',
              description:
                  'Dedicated gluten-free prep area and labeled menu items',
              icon: Icons.do_not_touch,
            ),
            _DietaryOptionTile(
              title: 'Halal Options',
              description: 'Available daily at Wilson Hall Dining Commons',
              icon: Icons.food_bank,
            ),
            _DietaryOptionTile(
              title: 'Kosher Options',
              description: 'Available at 45 Willcocks Street Bistro',
              icon: Icons.synagogue,
            ),
            _DietaryOptionTile(
              title: 'Food Allergy Accommodations',
              description:
                  'Individual consultations available with dining services',
              icon: Icons.coronavirus,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Feedback and Contact
        const _SectionHeader(
          title: 'Feedback & Contact',
          icon: Icons.contact_support,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We Value Your Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us improve your dining experience by sharing your thoughts and suggestions.',
                  style: TextStyle(fontSize: 14, color: AppColors.textDark),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.rate_review),
                        label: const Text('Submit Feedback'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.contact_mail),
                        label: const Text('Contact Us'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Dining Services Director:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('Sarah Johnson'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'dining@newcollege.utoronto.ca',
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '416-555-1234',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Extra space at bottom for better scrolling
        const SizedBox(height: 40),
      ],
    );
  }
}

// Dining Feature Card
class _FeaturedDiningCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const _FeaturedDiningCard({
    required this.name,
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
                height: 180,
                width: double.infinity,
                color: AppColors.primaryBlue.withOpacity(0.2),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.restaurant,
                            size: 64,
                            color: AppColors.primaryBlue.withOpacity(0.5),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'OPEN NOW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Busy: 65%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                    name,
                    style: const TextStyle(
                      fontSize: 20,
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
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.map),
                          label: const Text('Directions'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.menu_book),
                          label: const Text('Full Menu'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
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

// Menu Highlight Card
class _MenuHighlightCard extends StatelessWidget {
  final String mealType;
  final String timeRange;
  final List<String> highlights;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuHighlightCard({
    required this.mealType,
    required this.timeRange,
    required this.highlights,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mealType,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          timeRange,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getMealStatusColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getMealStatus(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Menu Highlights:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...highlights.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.restaurant_menu, size: 16),
                  label: const Text('Complete Menu'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMealStatus() {
    // This would be dynamic based on current time in a real app
    if (mealType == 'Breakfast') return 'ENDED';
    if (mealType == 'Lunch') return 'ACTIVE';
    return 'UPCOMING';
  }

  Color _getMealStatusColor() {
    // This would be dynamic based on current time in a real app
    if (mealType == 'Breakfast') return Colors.grey;
    if (mealType == 'Lunch') return Colors.green;
    return Colors.orange;
  }
}

// Meal Plan Card
class _MealPlanCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final List<String> features;
  final bool recommended;
  final VoidCallback onTap;

  const _MealPlanCard({
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    required this.recommended,
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Features:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...features.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Learn More'),
                    ),
                  ),
                ],
              ),
            ),
            if (recommended)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryRed,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Dining Location Card
class _LocationCard extends StatelessWidget {
  final String name;
  final String hours;
  final String description;
  final List<IconData> icons;
  final VoidCallback onTap;

  const _LocationCard({
    required this.name,
    required this.hours,
    required this.description,
    required this.icons,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'OPEN NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children:
                            icons
                                .map(
                                  (icon) => Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      icon,
                                      size: 16,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Hours:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hours,
                style: TextStyle(fontSize: 13, color: AppColors.textLight),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map, size: 16),
                      label: const Text('Directions'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.restaurant_menu, size: 16),
                      label: const Text('Menu'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
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

// Dietary Option Tile
class _DietaryOptionTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _DietaryOptionTile({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 14, color: AppColors.textLight),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
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

// Registrar Tab Placeholder
class _RegistrarTab extends StatelessWidget {
  const _RegistrarTab();

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
